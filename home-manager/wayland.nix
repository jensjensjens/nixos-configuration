{ pkgs, config, ...}:

{
    xdg.configFile.electron = {
        text = ''
            --enable-features=UseOzonePlatform 
            --ozone-platform=wayland
        '';
        target = "electron-flags.conf";
    };
  xdg.configFile.background = {
    source = ./. + "/background.png";
    target = "background.png";
  };
}
