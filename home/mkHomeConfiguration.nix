{
  username,
  nixpkgs,
  additionalConfigs,
  ...
}:
let
  standardConfig = {
    home.username = username;
    home.stateVersion = "25.05";
    home.enableNixpkgsReleaseCheck = false;
  };
  shellConfig = import ./shell.nix;
in
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  users.users.${username}.home = "/Users/${username}";
  home-manager.backupFileExtension = "backup";

  home-manager.users.${username} = nixpkgs.lib.mkMerge [
    standardConfig
    shellConfig
    additionalConfigs
  ];
}
