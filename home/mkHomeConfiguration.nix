{
  username,
  home-manager,
  nixpkgs,
  configs,
}:
let
  standardConfig = {
    home.username = username;
    home.stateVersion = "25.05";
    home.enableNixpkgsReleaseCheck = false;
  };
in
home-manager.darwinModules.home-manager {

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  users.users.${username}.home = "/Users/${username}";
  home-manager.backupFileExtension = "backup";

  home-manager.users.${username} = nixpkgs.lib.mkMerge [
    standardConfig
    configs
  ];
}
