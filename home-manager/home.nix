{ config, pkgs, lib, ... }:

let
  imports =
    [
      ./packages.nix
      ./alacritty.nix
      ./git.nix
      ./zsh.nix
      ./tmux.nix
      ./hyprland.nix
      ./virt-manager/virt-manager.nix
    ];
in
{
  imports = imports;

  home = {
    stateVersion = "23.05";
    username = "jenss";
    homeDirectory = "/home/jenss";

    sessionVariables = {
      DOCKER_BUILDKIT = 1;
      MANPAGER = "page -t man";
      PAGER = "page";
      PULUMI_SKIP_UPDATE_CHECK = "true";
      NIXOS_OZONE_WL = "1";
    };

    shellAliases = {
      watch = "${pkgs.viddy}/bin/viddy";
      tree =
        "${pkgs.eza}/bin/eza --all --tree --ignore-glob '__pycache__|node_modules|.git|venv|obj' --icons --sort type";
      config = "${pkgs.git}/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      configui = "${pkgs.gitui}/bin/gitui -d $HOME/.cfg -w $HOME";
    };

    file = {
      bin = {
        source = ./. + "/bin";
        target = "bin";
      };
    };
  };

  xdg = {
    configFile = {
      gitui = { source = ./. + "/gitui"; };

      starship = {
        source = ./. + "/starship.toml";
        target = "starship.toml";
      };
      xdgDesktopPortalWlr = {
        text = ''
          [screencast]
          output_name=
          max_fps=30
          chooser_cmd="slurp -f %o -o"
          chooser_type=simple'';
        target = "xdg-desktop-portal-wlr/config";
      };
    };
  };

  programs = {
    chromium = {
      enable = true;
      # commandLineArgs = [
      #   "--enable-features=WebRTCPipeWireCapturer"
      # ];
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [ "-p 80%,60%" ];
      };
    };

    gh = {
      enable = true;
      settings = { git_protocol = "ssh"; };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      config = { theme = "zenburn"; };
    };

    eza = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };

    k9s = { enable = true; };

    # ssh = {
    #     enable = true;
    #     matchBlocks = {
    #         "*" = {
    #             identityAgent = "~/.1password/agent.sock";
    #         };
    #     };
    # };

    # Let Home Manager install and manage itself.
    home-manager = { enable = true; };
  };
}
