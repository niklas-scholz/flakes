{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.chezmoi
    pkgs.deno
    pkgs.bun
    pkgs.alacritty
    pkgs.nixfmt-rfc-style
    pkgs.lazygit
    pkgs.starship
    pkgs.vim
    pkgs.neovim
    pkgs.tmux
    pkgs.devpod
    pkgs.xplr
    pkgs.terraformer
    pkgs.pipx
    pkgs.gh
    pkgs.nodejs
    pkgs.corepack
  ];

  homebrew = {
    casks = [
      "dbeaver-community"
      "ghostty"
    ];

    brews = [
      "git"
      "postgresql@14"
      "pyenv"
      "tfenv"
    ];
  };

}
