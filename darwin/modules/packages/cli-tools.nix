{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ack
    bat
    claude-code
    circumflex
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
