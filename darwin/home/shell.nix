{
  config,
  lib,
  pkgs,
  ...
}:
let
  zshCoreHooks = lib.mkOrder 1000 ''
    # Load zsh-vi-mode
    source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

    # ZVM HOOK: Load Fzf completion after vi-mode initialization
    function zvm_after_init() {
      bindkey '\eg' fzf-cd-widget
      if [[ -x ${pkgs.fzf}/bin/fzf ]]; then
        eval "$(${pkgs.fzf}/bin/fzf --zsh)"
      fi

      FZF_GIT_SH="$HOME/.config/zsh/fzf-git.sh"
      if [ ! -f "$FZF_GIT_SH" ]; then
        echo "Downloading fzf-git.sh to $FZF_GIT_SH"
        mkdir -p "$(dirname "$FZF_GIT_SH")"
        curl -fsSL https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -o "$FZF_GIT_SH"
      fi
      source "$FZF_GIT_SH"
    }
  '';

  zshFzfCustoms = lib.mkOrder 1050 ''
    # fzf integration for path completions uses 'fd'
    _fzf_compgen_path() { fd --hidden --follow . "$1"; }
    _fzf_compgen_dir() { fd --type d --hidden --follow . "$1"; }
  '';
in
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };

      sessionVariables = {
        DELTA_PAGER = "less -R";
        EDITOR = "nvim";
      };

      initContent = lib.mkMerge [
        zshCoreHooks
        zshFzfCustoms
      ];

      shellAliases = {
        vim = "nvim";
        v = "nvim";
        vi = "nvim";

        t = "tmux";
        ta = "t a";

        cz = "chezmoi";

        cat = "bat";
        c = "clear";
        e = "exit";

        ls = "lsd";
        du = "dust";
        grep = "rg";
        find = "fd";
        lz = "lazygit";
        cd = "z";

        gcob = "_fzf_git_branches --no-multi | xargs git checkout";
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = false; # handled manually to ensure compatibility with zsh-vi-mode
      defaultCommand = "fd --hidden --strip-cwd-prefix";
      fileWidgetCommand = "fd --hidden --strip-cwd-prefix";
      changeDirWidgetCommand = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
