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
    pkgs.git
    pkgs.tenv
  ];

  homebrew = {
    casks = [
      "dbeaver-community"
      "ghostty"
    ];
  };
}
