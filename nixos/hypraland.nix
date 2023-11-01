{ config, pkgs, ... }:
let
in
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  security.pam.services.swaylock = { };

  environment.systemPackages = with pkgs; [
    sway-contrib.grimshot # screenshot
    wdisplays # tool to configure displays
    wofi # menu
    hyprpaper
  ];
}
