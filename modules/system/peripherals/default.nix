{ ... }:
{
  imports = [
    ./trackpad.nix
    ./keyboard.nix
    ./mouse.nix
  ];

  system.defaults.CustomUserPreferences = {
    # Increase sound quality for Bluetooth headphones/headsets
    com.apple.BluetoothAudioAgent."Apple Bitpool Min (editable)" = 40;
    # Disable “Natural” scrolling direction
    system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  };

}
