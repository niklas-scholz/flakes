{
  config,
  lib,
  pkgs,
  ...
}:

let
  zshDownloadHelper = ''
    download_and_source() {
      local url="$1"
      local dest="$2"
      local name
      name=$(basename "$dest")

      if [ ! -f "$dest" ]; then
        echo "Downloading $name → $dest"
        mkdir -p "$(dirname "$dest")"
        curl -fsSL "$url" -o "$dest"
      fi

      source "$dest"
    }
  '';

  zshClipboardSetup = lib.mkOrder 950 ''
    export ZVM_SYSTEM_CLIPBOARD_ENABLED=true
  '';

  zshViModeSetup = ''
    ${zshDownloadHelper}

    ZSH_VI_MODE_SCRIPT="$HOME/.config/zsh/zsh-vi-mode/zsh-vi-mode.zsh"

    download_and_source \
      "https://raw.githubusercontent.com/jeffreytse/zsh-vi-mode/master/zsh-vi-mode.zsh" \
      "$ZSH_VI_MODE_SCRIPT"
  '';

  fzfGitSetup = ''
    ${zshDownloadHelper}

    FZF_GIT_SH="$HOME/.config/zsh/fzf-git.sh"

    download_and_source \
      "https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh" \
      "$FZF_GIT_SH"
  '';

  zshZvmAfterInit = lib.mkOrder 1010 ''
    function zvm_after_init() {
      bindkey '\eg' fzf-cd-widget

      # Load fzf integration manually (after zsh-vi-mode)
      if [[ -x ${pkgs.fzf}/bin/fzf ]]; then
        eval "$(${pkgs.fzf}/bin/fzf --zsh)"
      fi

      ${fzfGitSetup}
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
        zshClipboardSetup
        zshViModeSetup
        zshZvmAfterInit
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
