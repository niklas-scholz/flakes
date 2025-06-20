{
  home-manager,
  username,
  extraConfig,
}:
let
  pkgs = import <nixpkgs> { };
  standardConfig = {
    home.username = username;
    home.stateVersion = "25.05";
    home.enableNixpkgsReleaseCheck = false;
  };
  shellConfig = import ./shell.nix;
in
{
  imports = [
    home-manager.darwinModules.home-manager
    {

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      users.users.${username}.home = "/Users/${username}";
      home-manager.backupFileExtension = "backup";

      home-manager.users.${username} = pkgs.lib.mkMerge [
        standardConfig
        shellConfig
        extraConfig
      ];
    }
  ];
}
