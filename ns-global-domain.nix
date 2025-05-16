{ pkgs, ... }:
{
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
  };
}
