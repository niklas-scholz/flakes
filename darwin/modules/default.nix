{ config, brewUpgrade ? false, ... }:
{
  imports = [
    ./system
    ./packages
    ./fonts.nix
  ];

  nix-homebrew = {
    enable = true;
    user = config.system.primaryUser;
    autoMigrate = true;
    trust.taps = [ "nikitabobko/tap" ];
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = brewUpgrade;
      upgrade = brewUpgrade;
    };
  };
}
