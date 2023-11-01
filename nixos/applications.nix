{ config, lib, pkgs, ... }:

 {

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    _1password
    _1password-gui
    alacritty  
    brightnessctl
    firefox
    gnome.gedit
    gnome.gnome-calculator
    gnome.gnome-calendar
    gnome.gnome-font-viewer
    gthumb
    hyprpaper
    networkmanagerapplet # Better applet for network
    slack
    spotify
    sway-contrib.grimshot # screenshot
    sway-contrib.grimshot # screenshot
    swayidle
    swaylock
    swaynotificationcenter
    thunderbird
    virt-manager
    wdisplays # tool to configure displays
    wofi # menu
    xdg-desktop-portal-hyprland
    waybar
  ];
}
