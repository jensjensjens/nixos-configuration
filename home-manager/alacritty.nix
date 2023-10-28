{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "Terminal";

        padding = {
          y = 10;
          x = 5;
        };
        dimensions = {
          lines = 75;
          columns = 100;
        };
      };

      font = {
        normal.family = "MesloLgm Nerd Font Mono";
        size = 11.0;
      };

      shell = { program = "${pkgs.zsh}/bin/zsh"; };
    };
  };
}
