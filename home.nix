{ config, pkgs, ... }:
{
  home.username = "niklasscholz";
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
      };
      sessionVariables = {
        DELTA_PAGER = "less -R";
        EDITOR = "nvim";

      };

      initContent = ''
        bindkey '\eg' fzf-cd-widget

        FZF_GIT_SH="$HOME/.config/zsh/fzf-git.sh"
        if [ ! -f "$FZF_GIT_SH" ]; then
          echo "Downloading fzf-git.sh to \$FZF_GIT_SH"
          mkdir -p "$(dirname "$FZF_GIT_SH")"
          curl -fsSL https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -o "$FZF_GIT_SH"
        fi

        source "$FZF_GIT_SH"

        # "**" command syntax
        _fzf_compgen_path() {
          fd --hidden --follow . "$1"
        }
        # "**" command syntax (for directories only)
        _fzf_compgen_dir() {
          fd --type d --hidden --follow . "$1"
        }
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
      };

    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --hidden --strip-cwd-prefix";
      # Command line options for the CTRL-T keybinding.
      fileWidgetCommand = "fd --hidden --strip-cwd-prefix";
      # The command that gets executed as the source for skim for the ALT-C keybinding
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
