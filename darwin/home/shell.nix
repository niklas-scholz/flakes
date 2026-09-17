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

  zshZvmAfterInit = lib.mkOrder 1010 ''
    function zvm_after_init() {
      bindkey '\eg' fzf-cd-widget

      source ${fzfGitSrc}

      # Load fzf integration manually (after zsh-vi-mode)
      if [[ -x ${pkgs.fzf}/bin/fzf ]]; then
        eval "$(${pkgs.fzf}/bin/fzf --zsh)"
      fi

      # Load atuin manually so its Ctrl-R binding wins over zsh-vi-mode
      if [[ -x ${pkgs.atuin}/bin/atuin ]]; then
        eval "$(${pkgs.atuin}/bin/atuin init zsh)"
      fi

    }
  '';

  zshFzfCustoms = lib.mkOrder 1050 ''
    # fzf integration for path completions uses 'fd'
    _fzf_compgen_path() { fd --hidden --follow . "$1"; }
    _fzf_compgen_dir() { fd --type d --hidden --follow . "$1"; }
  '';

  zshScratchFns = ''
    vt() {
      mkdir -p "$HOME/scratch"
      nvim "$(mktemp "$HOME/scratch/scratch.XXXXXX")"
    }

    vtl() {
      mkdir -p "$HOME/scratch"
      local file
      file=$(fd . "$HOME/scratch" --type f | fzf --preview 'bat --color=always {}') || return
      nvim "$file"
    }
  '';
in
{
  xdg.enable = true;

  home.sessionPath = [
    "$HOME/.local/share/pnpm/bin"
  ];

  programs = {
    zsh = {
      enable = true;
      dotDir = config.home.homeDirectory;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };

      sessionVariables = {
        PNPM_HOME = "$HOME/.local/share/pnpm";
        DELTA_PAGER = "less -R";
        EDITOR = "nvim";
      };

      initContent = lib.mkMerge [
        zshClipboardSetup
        zshViModeSetup
        zshZvmAfterInit
        zshFzfCustoms
        zshScratchFns
      ];

      shellAliases = {
        c = "clear";
        e = "exit";
        gcob = "_fzf_git_branches --no-multi | xargs git checkout";
        # Reload shell
        reload = "exec $SHELL";
        # Show path entries
        path = "echo $PATH | tr ':' '\\n'";

        vim = "nvim";
        v = "nvim";
        vi = "nvim";
        cz = "chezmoi";
        t = "tmux";
        ta = "t a";

        cat = "bat";
        cd = "z";
        ls = "lsd";
        du = "dust";
        grep = "rg";
        find = "fd";
        ps = "procs";

        lz = "lazygit";
        lzd = "lazydocker";

        denv = "direnv exec . $SHELL";

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
      fileWidget.command = "fd --hidden --strip-cwd-prefix";
      changeDirWidget.command = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = false;
    };

    atuin = {
      enable = true;
      enableZshIntegration = false; # handled manually to ensure compatibility with zsh-vi-mode
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    yazi = {
      enable = true;
      shellWrapperName = "yy";
      enableZshIntegration = true;
    };
  };
}
