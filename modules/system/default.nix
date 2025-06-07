{ pkgs, ... }:
{
  imports = [
    ./peripherals/default.nix
    ./finder.nix
    ./screenshots.nix
    ./activity-monitor.nix
    ./dock.nix
    ./zsh.nix
  ];
  # Disable quarantine for downloaded applications
  system.defaults.LaunchServices.LSQuarantine = false;

  system.defaults.NSGlobalDomain = {
    AppleShowScrollBars = "Always";

    # Disable automatic capitalization as it’s annoying when typing code
    NSAutomaticCapitalizationEnabled = false;
    # Disable smart dashes as they’re annoying when typing code
    NSAutomaticDashSubstitutionEnabled = false;
    # Disable smart quotes as they’re annoying when typing code
    NSAutomaticQuoteSubstitutionEnabled = false;
    # Disable auto-correct
    NSAutomaticSpellingCorrectionEnabled = false;

    # For some reason, mission control doesn’t like that AeroSpace puts a lot of windows in the bottom right corner of the screen. Mission control shows windows too small even there is enough space to show them bigger.
    NSWindowShouldDragOnGesture = true;
  };
}
