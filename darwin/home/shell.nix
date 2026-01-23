{
  config,
  lib,
  pkgs,
  ...
}:

let
  zshViModeSrc = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/jeffreytse/zsh-vi-mode/v0.12.0/zsh-vi-mode.zsh";
    sha256 = "0sap5d1s0g033717gpfw6mlr10kkkhiznl5y6dczcizz5pm5gjki";
  };

  fzfGitSrc = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/junegunn/fzf-git.sh/c823ffd/fzf-git.sh";
    sha256 = "1iv8s7mz4ad6zmhk1imrl96z9n6cv53bizl6svhi4fafh7i0v8iy";
  };

  zshClipboardSetup = lib.mkOrder 950 ''
    export ZVM_SYSTEM_CLIPBOARD_ENABLED=true
  '';

  zshViModeSetup = ''
    source ${zshViModeSrc}
  '';

  fzfGitSetup = ''
    source ${fzfGitSrc}
  '';

  zshZvmAfterInit = lib.mkOrder 1010 ''
    function zvm_after_init() {
      bindkey '\eg' fzf-cd-widget

      # Load fzf integration manually (after zsh-vi-mode)
      if [[ -x ${pkgs.fzf}/bin/fzf ]]; then
        eval "$(${pkgs.fzf}/bin/fzf --zsh)"
      fi

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
        K9S_CONFIG_DIR = "${config.home.homeDirectory}/.config/k9s";
      };

      initContent = lib.mkMerge [
        zshClipboardSetup
        zshViModeSetup
        zshZvmAfterInit
        fzfGitSetup
        zshFzfCustoms
      ];

      shellAliases = {
        c = "clear";
        e = "exit";
        cd = "z";

        vim = "nvim";
        v = "nvim";
        vi = "nvim";

        t = "tmux";
        ta = "t a";

        cz = "chezmoi";
        cat = "bat";

        ls = "lsd";
        du = "dust";
        grep = "rg";
        find = "fd";
        lz = "lazygit";
        lzd = "lazydocker";

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
