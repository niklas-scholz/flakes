{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.ack
    pkgs.bat
    pkgs.fd
    pkgs.fzf
    pkgs.dust
    pkgs.zoxide
    pkgs.wget
    pkgs.tree
    pkgs.tldr
    pkgs.lsd
    pkgs.less
    pkgs.htop
    pkgs.delta
    pkgs.ripgrep
    pkgs.thefuck
    pkgs.silver-searcher
    pkgs.yazi
  ];

  homebrew = {
    brews = [
      "zsh"
      "zsh-syntax-highlighting"
    ];
  };

}
