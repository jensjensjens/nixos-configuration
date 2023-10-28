{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    mouse = false;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    extraConfig = ''
      ${builtins.readFile ./tmux/tmux-extras.config}
    '';

    plugins = with pkgs; [ tmuxPlugins.yank tmuxPlugins.gruvbox ];
  };
}
