{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    chezmoi
    alacritty
    lazygit
    neovim
    tmux
    devpod
    gh
    git
    k9s
    delta
  ];

  homebrew = {
    casks = [
      "dbeaver-community"
      "ghostty"
    ];
  };
}
