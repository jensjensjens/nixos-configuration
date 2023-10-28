{ config, pkgs, ... }:

{
  xdg.configFile.wofi = { source = ./. + "/wofi"; };
}
