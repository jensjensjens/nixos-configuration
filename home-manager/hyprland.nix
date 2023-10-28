{ pkgs, config, ...}:

{
  imports = [ ./wofi.nix ];
  xdg.configFile.waybar = { source = ./. + "/waybar"; };
  xdg.configFile.background = {
    source = ./. + "/background.png";
    target = "background.png";
  };

  programs.waybar.enable = true;

  xdg.configFile.hyprland = {
    source = ./. + "/hyprland";
    target = "hypr";
  };
}
