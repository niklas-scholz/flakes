# nix-darwin-base/flake.nix
{
  description = "Nik's nix-darwin base flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      ...
    }:
    let
      baseModule =
        { pkgs, ... }:
        {
          security.pam.enableSudoTouchIdAuth = true;
          nix.settings.experimental-features = "nix-command flakes";
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 5;
          nixpkgs.hostPlatform = "aarch64-darwin";

          # Add your shared config here or in ./modules/*
        };
    in
    {
      # Export baseModule to be reused by other flakes
      nixosModules.default = baseModule;

      # Optionally export modules as attrset for convenience
      modules = import ./modules;

      # You can also export a complete darwinConfiguration for testing base only
      darwinConfigurations."base-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          baseModule
        ] ++ builtins.attrValues (import ./modules);
      };
    };
}
