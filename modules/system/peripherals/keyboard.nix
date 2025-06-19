{ ... }:
{
  system.defaults.NSGlobalDomain = {
    # Set a blazingly fast keyboard repeat rate
    KeyRepeat = 1;
    InitialKeyRepeat = 10;
    # Disable press-and-hold for keys in favor of key repeat
    ApplePressAndHoldEnabled = false;

    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    AppleKeyboardUIMode = 3;
  };

}
