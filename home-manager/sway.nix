{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./wayland.nix 
    ./wofi.nix 
  ];

  xdg.configFile.waybar = { source = ./. + "/waybar"; };
  xdg.configFile.kanshi = {
    target = "kanshi/config";
    text = "";
  };

  services = {
    swayidle = {
      enable = true;
      events = [{
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }];
      timeouts = [
        {
          timeout = 301;
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          timeout = 600;
          command =
            ''swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"'';
        }
      ];
    };
  };

  programs.waybar = { enable = true; };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
      fonts = {
        names = [ "Noto Sans CJK TC" ];
        style = "DemiLight";
        size = 10.0;
      };
      startup = [
        { command = "systemctl --user start swayidle.service"; }
        {
          command = "nm-applet --indicator";
          always = true;
        }
        { command = "swaync"; }
        { command = "sleep 5; systemctl --user start kanshi.service"; }
        { command = "dbus-sway-environment"; }
        { command = "configure-gtk"; }
      ];
      window = { titlebar = false; };
      focus = { followMouse = false; };
      terminal = "${pkgs.alacritty}/bin/alacritty";

      modifier = "Mod4";
      keybindings =
        let modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+d" = "exec ${pkgs.wofi}/bin/wofi --dmenu --show drun";
          "${modifier}+p" = "exec grimshot save active";
          "${modifier}+Shift+p" = "exec grimshot copy area";
          "Ctrl+space" = "input type:keyboard xkb_switch_layout next";
        };
      input = {
        "type:keyboard" = {
          xkb_options = "caps:escape";
          xkb_layout = "us,se";
          xkb_numlock = "enable";
          repeat_delay = "250";
          repeat_rate = "30";
        };
        "1739:31251:DLL06E4:01_06CB:7A13_Touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };
      gaps = {
        inner = 5;
        top = 0;
        left = 2;
        right = 2;
        bottom = 2;
      };
      output = {
        "*" = { bg = "${config.xdg.configHome}/background.png fill"; };
      };
    };
  };
}
