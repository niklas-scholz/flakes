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
    rainfrog
  ];

  homebrew = {
    casks = [
      "dbeaver-community"
      "ghostty"
      "visual-studio-code"
      "freelens"
    ];
  };
}
