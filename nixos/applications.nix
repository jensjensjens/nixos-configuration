{ config, lib, pkgs, ... }:

 {

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    _1password
    _1password-gui
    alacritty  
    firefox
    gnome.gedit
    gnome.gnome-calculator
    gnome.gnome-calendar
    gnome.gnome-font-viewer
    gthumb
    networkmanagerapplet # Better applet for network
    slack
    spotify
    sway-contrib.grimshot # screenshot
    swayidle
    swaylock
    swaynotificationcenter
    thunderbird
    virt-manager
    xdg-desktop-portal-hyprland
  ];
}
