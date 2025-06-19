{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    chezmoi
    alacritty
    nixfmt-rfc-style
    lazygit
    neovim
    tmux
    devpod
    gh
    git
  ];

  homebrew = {
    casks = [
      "dbeaver-community"
      "ghostty"
    ];
  };
}
