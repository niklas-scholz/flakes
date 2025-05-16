{ pkgs, ... }:
{
  # Enable trackpad tap to click
  system.defaults.trackpad.Clicking = true;
  # Enable trackpad secondary click
  system.defaults.NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;
  # Configures the trackpad corner click behavior. Mode 1 enables right click
  system.defaults.NSGlobalDomain."com.apple.trackpad.trackpadCornerClickBehavior" = 1;
  # Enable trackpad right click
  system.defaults.trackpad.TrackpadRightClick = true;
  # Faster trackpad
  system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 5.0;
}
