{
  home-manager,
  username,
  extraConfig,
}:
let
  pkgs = import <nixpkgs> { };
  standardConfig = {
    home = {
      inherit username;
      stateVersion = "25.05";
      enableNixpkgsReleaseCheck = false;
      sessionPath = [
        "$(corepack yarn global bin):$PATH"
      ];
      packages = with pkgs; [
        nodejs
        (writeShellScriptBin "pnpm" ''
          exec ${nodejs_20}/bin/corepack pnpm "$@"
        '')
        (writeShellScriptBin "yarn" ''
          exec ${nodejs_20}/bin/corepack yarn "$@"
        '')
      ];
    };
  };
  shellConfig = import ./shell.nix;
in
{
  imports = [
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        users.${username} = pkgs.lib.mkMerge [
          standardConfig
          shellConfig
          extraConfig
        ];
      };

      users.users.${username}.home = "/Users/${username}";
    }
  ];
}
