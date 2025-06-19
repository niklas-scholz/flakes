{ ... }:
{
  system.defaults = {
    dock = {
      orientation = "left";
      # Automatically hide and show the Dock
      autohide = true;
      # Whether to group windows by application in Mission Control’s Exposé. The default is false.
      expose-group-apps = true;
      # Set the icon size of Dock items to 24 pixels
      tilesize = 24;
      # show indicator lights for open applications in the dock
      show-process-indicators = true;
      # Don’t animate opening applications from the Dock
      launchanim = false;
      # Speed up Mission Control animations
      expose-animation-duration = 0.1;
      # Remove the auto-hiding Dock delay
      autohide-delay = 0.0;
      # Remove the animation when hiding/showing the Dock
      autohide-time-modifier = 0.0;
      # Make Dock icons of hidden applications translucent
      showhidden = true;
      # Don’t show recent applications in Dock
      show-recents = false;
      # Show appswitcher on all windows
      appswitcher-all-displays = true;

      # Disable hot corners
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };
  };
}
