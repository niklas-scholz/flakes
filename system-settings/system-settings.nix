{ pkgs, ... }:
{
  imports = [
    ./os-general.nix
    ./finder.nix
    ./screenshots.nix
    ./peripherals.nix
  ];
}
