{ ... }:
{
  # Trackpad hardware-level settings
  system.defaults = {
    trackpad = {
      # Enable tap to click
      Clicking = true;
      # Enable right click
      TrackpadRightClick = true;
    };

    # User-level trackpad preferences
    NSGlobalDomain = {
      # Enable secondary click
      "com.apple.trackpad.enableSecondaryClick" = true;
      # Set corner behavior (1 = right click)
      "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
      # Increase tracking speed
      "com.apple.trackpad.scaling" = 5.0;
    };
  };
}
