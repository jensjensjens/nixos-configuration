{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableVteIntegration = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    history.share = true;

    initExtra = ''
        source <(${pkgs.kubectl}/bin/kubectl completion zsh)
        source <(${pkgs.kubernetes-helm}/bin/helm completion zsh)
        source <(${pkgs.fluxcd}/bin/flux completion zsh)
        source <(${pkgs.pulumi}/bin/pulumi gen-completion zsh)
    '';
  };
}
