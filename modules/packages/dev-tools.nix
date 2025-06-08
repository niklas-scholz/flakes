{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.chezmoi
    pkgs.alacritty
    pkgs.nixfmt-rfc-style
    pkgs.lazygit
    pkgs.neovim
    pkgs.tmux
    pkgs.devpod
    pkgs.gh
    pkgs.git
  ];

  homebrew = {
    casks = [
      "dbeaver-community"
      "ghostty"
    ];
  };
}
