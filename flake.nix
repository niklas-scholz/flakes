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
      configuration =
        { pkgs, ... }:
        {
          system.primaryUser = "niklasscholz";
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
      username = "niklasscholz";
      # general = import ./home {
      #   username = username;
      # };
      workConfig = import ./home/work.nix;
      mkHomeConfiguration = import ./home/mkHomeConfiguration.nix;

    in
    {
      darwinConfigurations."MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          ./hosts/private.nix
          home-manager.darwinModules.home-manager
          {

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            users.users.${username}.home = "/Users/${username}";
            home-manager.backupFileExtension = "backup";

            home-manager.users.${username} = import ./home {
              username = username;
            };
          }
        ];
      };
      darwinConfigurations."Niklass-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          ./hosts/work.nix
          home-manager.darwinModules.home-manager
          (mkHomeConfiguration {
            inherit username;
            inherit nixpkgs;
            configs = workConfig;
          })
        ];
      };
    };
}
