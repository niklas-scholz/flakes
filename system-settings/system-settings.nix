{ pkgs, ... }:
{
  imports = [
    ./os-general.nix
    ./finder.nix
    ./screenshots.nix
    ./peripherals.nix
    ./activity-monitor.nix
  ];
  # Disable quarantine for downloaded applications
  system.defaults.LaunchServices.LSQuarantine = false;

}
