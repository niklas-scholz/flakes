{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ack
    bat
    fd
    dust
    zoxide
    wget
    tree
    tldr
    lsd
    less
    htop
    ripgrep
    thefuck
    silver-searcher
    yazi
    starship
  ];
}
