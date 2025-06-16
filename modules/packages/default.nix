{ pkgs, ... }:
{
  imports = [
    ./browsers.nix
    ./cli-tools.nix
    ./dev-tools.nix
    ./others.nix
    ./supercharge.nix
    ./langs.nix
  ];

  homebrew = {
    enable = true;
  };

}
