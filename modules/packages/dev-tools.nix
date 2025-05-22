{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.chezmoi
    pkgs.deno
    pkgs.alacritty
    pkgs.nixfmt-rfc-style
    pkgs.lazygit
    pkgs.starship
    pkgs.vim
    pkgs.neovim
    pkgs.tmux
    pkgs.devpod
    pkgs.xplr
  ];

  homebrew = {
    casks = [
      "dbeaver-community"
      "ghostty"
    ];

    brews = [
      "git"
      "nvm"
      "pipx"
      "pnpm"
      "postgresql@14"
      "pyenv"
      "terraformer"
      "tfenv"
    ];
  };

}
