{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jens Sigvardsson";
    userEmail = "19902144+jensjensjens@users.noreply.github.com";
    aliases = {
      commit-amend = "commit --amend -C HEAD";
      commit-undo = "reset --soft HEAD^";
      log-tag = "log --oneline --decorate --tags --no-walk";
      log-tree-all = "log --oneline --decorate --graph --all";
      log-tree =
        "log --all --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      pfetch = "fetch --prune";
      violence =
        "git add . && git commit --amend --no-edit && git push --force-with-lease";
      log-new = "log main..HEAD";
      log-old = "log HEAD..main";
    };
    includes = [{ path = "~/.config/git/config-work"; }];
    extraConfig = {
      user = { signingkey = "~/.ssh/github-personal.pub"; };
      core = {
        editor = "nvim";
        sshCommand = "ssh -i ~/.ssh/github-personal";
      };
      push = { default = "current"; };
      commit = { gpgsign = true; };
      gpg = { format = "ssh"; };
      tag = { gpgsign = true; };
      diff = { tool = "vimdiff"; };
      difftool = { prompt = false; };
      mergetool = { prompt = false; };
      pull = { rebase = true; };
      init = { defaultBranch = "main"; };
      rebase = { autoStash = true; };
    };
    delta = {
      enable = true;
      options = { line-numbers = false; };
    };
  };
}
