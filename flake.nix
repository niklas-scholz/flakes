{
  description = "Nik's minimal nix-darwin config library for shared use";

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
        {
          username,
          hostPlatform ? "aarch64-darwin",
        }:
        { pkgs, ... }:
        {
          system.primaryUser = username;

          # Enable touch ID authentication for sudo.
          security.pam.services.sudo_local.touchIdAuth = true;
          # Required for touch ID authentication to work in tmux
          environment = {
            etc."pam.d/sudo_local".text = ''
              # Managed by Nix Darwin
              auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
            '';
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = hostPlatform;

          nixpkgs.config.allowUnfree = true;
        };

      mkHomeConfiguration = import ./home/mkHomeConfiguration.nix;
      minimalModules = import ./modules;
      mkDarwinConfiguration =
        {
          username,
          extraModules ? [ ],
          extraHomeManagerConfiguration ? { },
          cleanupHomebrew ? false,
          ...
        }:
        nix-darwin.lib.darwinSystem {
          modules = [
            (mkConfiguration { inherit username; })
            (minimalModules { inherit cleanupHomebrew; })

            (mkHomeConfiguration {
              inherit home-manager;
              inherit username;
              extraConfig = extraHomeManagerConfiguration;
            })
          ] ++ extraModules;
        };
    in
    {
      inherit mkDarwinConfiguration;
      inherit mkHomeConfiguration;
    };
}
