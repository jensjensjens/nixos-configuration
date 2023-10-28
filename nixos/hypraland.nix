{ config, pkgs, ... }:
let
in {
  programs.hyprland = {
  	enable = true;
  	xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    sway-contrib.grimshot # screenshot
    wdisplays # tool to configure displays
    wofi # menu
    hyprpaper
    waybar
  ];

  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
}
