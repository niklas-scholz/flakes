{
  config,
  lib,
  pkgs,
  ...
}:
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

      initContent = ''
        # --- Load zsh-vi-mode ---
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

        # --- ZVM HOOK: Load Fzf keybindings and completion after vi-mode initialization ---
        # This resolves the conflict and ensures Fzf's completion is active.
        function zvm_after_init() {
          # Use 'eval' to execute the Fzf setup script's output
          if [[ -x ${pkgs.fzf}/bin/fzf ]]; then
            eval "$(${pkgs.fzf}/bin/fzf --zsh)"
          fi
        }

        # --- fzf Custom Functions (Keep these) ---
        # fzf integration for path completions
        _fzf_compgen_path() { fd --hidden --follow . "$1"; }
        _fzf_compgen_dir() { fd --type d --hidden --follow . "$1"; }

        # --- fzf-git setup (Keep this) ---
        bindkey '\eg' fzf-cd-widget

        FZF_GIT_SH="$HOME/.config/zsh/fzf-git.sh"
        if [ ! -f "$FZF_GIT_SH" ]; then
          echo "Downloading fzf-git.sh to $FZF_GIT_SH"
          mkdir -p "$(dirname "$FZF_GIT_SH")"
          curl -fsSL https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -o "$FZF_GIT_SH"
        fi
        source "$FZF_GIT_SH"
      '';

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
        pyac = "source $(poetry env info --path)/bin/activate";
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
