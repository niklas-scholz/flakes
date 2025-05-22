{ pkgs, ... }:
{
  imports = [
    ./browsers.nix
    ./cli-tools.nix
    ./dev-tools.nix
    ./others.nix
    ./supercharge.nix
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
  };

}
