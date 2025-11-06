{
  config,
  lib,
  pkgs,
  ...
}:
let
  zshCoreHooks = lib.mkOrder 1000 ''
    # Load zsh-vi-mode
    ZVM_SYSTEM_CLIPBOARD_ENABLED=true

    ZSH_VI_MODE_DIR="$HOME/.config/zsh/zsh-vi-mode"
    ZSH_VI_MODE_SCRIPT="$ZSH_VI_MODE_DIR/zsh-vi-mode.zsh"

    if [ ! -f "$ZSH_VI_MODE_SCRIPT" ]; then
      echo "Downloading zsh-vi-mode to $ZSH_VI_MODE_DIR"
      mkdir -p "$ZSH_VI_MODE_DIR"
      curl -fsSL https://raw.githubusercontent.com/jeffreytse/zsh-vi-mode/master/zsh-vi-mode.zsh -o "$ZSH_VI_MODE_SCRIPT"
    fi

    source "$ZSH_VI_MODE_SCRIPT"

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
