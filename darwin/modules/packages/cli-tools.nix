{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ack
    bat
    curl
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
    silver-searcher
    yazi
    starship
    fzf
  ];
}
