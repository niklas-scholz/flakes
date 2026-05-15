{ config, ... }:
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
  };

  homebrew = {
    enable = true;
  };
}
