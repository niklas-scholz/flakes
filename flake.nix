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
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.ack
            pkgs.bat
            pkgs.chezmoi
            pkgs.deno
            pkgs.dust
            pkgs.fd
            pkgs.fzf
            pkgs.alacritty
            pkgs.nixfmt-rfc-style

          ];
          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    # system = import ./system-settings.nix { inherit pkgs; };
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#MacBook-Pro-2
      darwinConfigurations."general" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          ./system/defaults.nix
        ];
      };
    };
}
