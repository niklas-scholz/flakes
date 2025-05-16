{ pkgs, ... }:
{
  system.defaults = {
    # For some reason, mission control doesn’t like that AeroSpace puts a lot of windows in the bottom right corner of the screen. Mission control shows windows too small even there is enough space to show them bigger.
    NSGlobalDomain.NSWindowShouldDragOnGesture = true;
    dock = {
      autohide = true;
      # Whether to group windows by application in Mission Control’s Exposé. The default is false.
      system.defaults.dock.expose-group-apps = true;

    };
  };
}
