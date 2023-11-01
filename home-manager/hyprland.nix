{ pkgs, inputs, config, system, hyprland, ... }:

{
  imports = [ ./wofi.nix ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_WAYLAND_FORCE_DPI = "physical";
    QT_QPA_PLATFORM = "wayland-egl";
  };

  xdg.configFile.background = {
    source = ./. + "/background.png";
    target = "background.png";
  };

  xdg.configFile.hyprpaper = {
    text = ''
      ipc = off
      preload = ~/.config/background.png
      wallpaper = eDP-1,~/.config/background.png
      wallpaper = HDMI-A-1,~/.config/background.png
    '';
    target = "hypr/hyprpaper.conf";
  };

  xdg.configFile.electron = {
    text = ''
      --enable-features=UseOzonePlatform,WaylandWindowDecorations
      --ozone-platform=wayland
    '';
    target = "electron-flags.conf";
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  xdg.configFile.waybar = { source = ./. + "/waybar"; };

  services = {
    swayidle = {
      enable = true;
      systemdTarget = "hyprland-session.target";
      events = [{
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }];
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          timeout = 600;
          command = ''hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'';
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [
        "eDP-1,1920x1080,auto,1"
        "HDMI-A-1,3840x2160,auto,1.5"
      ];

      env = [
        "XCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      input = {
        kb_layout = "us,se";
        kb_options = "caps:escape";
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "yes"; # you probably want this
      };

      decoration = {
        rounding = 4;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
      };

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };

      exec-once = [
        "waybar"
      ];

      exec = [
        "hyprpaper"
        "nm-applet --indicator"
        "swaync"
      ];

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, return, exec, alacritty"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, d, exec, pkill wofi || wofi --show drun"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"
        "$mainMod, p, exec, grimshot save active"
        "SUPER_SHIFT, p, exec, grimshot copy area"
        "ctrl, space, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next"

        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "SUPER_SHIFT, h, resizeactive, -80 0"
        "SUPER_SHIFT, l, resizeactive, 80 0"
        "SUPER_SHIFT, j, resizeactive, 0 80"
        "SUPER_SHIFT, k, resizeactive, 0 -80"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessDown,exec,brightnessctl set 10%-"
        ", XF86MonBrightnessUp,exec,brightnessctl set 10%+"
      ];
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
      ];
    };
  };
}
