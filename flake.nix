{
  description = "Nik's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      baseDarwinModule =
        { pkgs, ... }:
        {
          # TODO: Fixme
          security.pam.enableSudoTouchIdAuth = true;
          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

        };
      sharedModules = builtins.attrValues (import ./modules);
    in
    {
      # Export this module for reuse
      # nixosModules.default = baseDarwinModule;

      nixosModules.default =
        { pkgs, ... }@args:
        {
          imports = [
            baseDarwinModule
          ] ++ sharedModules;
        };

      # darwinConfigurations."MacBook-Pro" = nix-darwin.lib.darwinSystem {
      #   modules = [
      #     baseDarwinModule
      #     ./modules
      #   ];
      # };
    };
}
