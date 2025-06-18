{
  description = "Nik's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    let
      mkConfiguration =
        { username, ... }:
        { pkgs, ... }:
        {
          system.primaryUser = username;
          security.pam.services.sudo_local.touchIdAuth = true;
          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          nixpkgs.config.allowUnfree = true;

        };
      mkHomeConfiguration = import ./home/mkHomeConfiguration.nix;
      minimalModules = import ./modules;
      mkDarwinConfiguration =
        {
          username,
          extraModules ? [ ],
          ...
        }:
        nix-darwin.lib.darwinSystem {
          modules = [
            (mkConfiguration { inherit username; })
            home-manager.darwinModules.home-manager
            (mkHomeConfiguration {
              inherit username;
              inherit nixpkgs;
            })
            minimalModules
          ] ++ extraModules;
        };
      # import ./darwin/mkDarwinConfiguration.nix
      #   { inherit inputs; };
    in
    {
      mkConfiguration = mkConfiguration;
      mkHomeConfiguration = mkHomeConfiguration;
      minimalModules = minimalModules;
      mkDarwinConfiguration = mkDarwinConfiguration;
    };
}
