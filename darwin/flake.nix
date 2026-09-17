{
  description = "Nik's minimal nix-darwin config library for shared use";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # nix-homebrew's default brew-src predates the `command_wrapper` cask DSL
        # artifact, which the Homebrew JSON API now requires. Pin to a release that has it.
        brew-src.url = "github:Homebrew/brew/6.0.21";
        brew-src.flake = false;
      };
    };

    llm-agents.url = "github:numtide/llm-agents.nix/396894b83c286c9f091e9e19de5a856bb0c3c47f";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      llm-agents,
      ...
    }:
    let
      mkConfiguration =
        {
          username,
          hostPlatform ? "aarch64-darwin",
        }:
        { pkgs, ... }:
        {
          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";
          system = {
            primaryUser = username;

            # Set Git commit hash for darwin-version.
            configurationRevision = self.rev or self.dirtyRev or null;

            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            stateVersion = 5;
          };

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = hostPlatform;

          nixpkgs.config.allowUnfree = true;
        };

      mkHomeConfiguration = import ./home/mkHomeConfiguration.nix;
      minimalModules = import ./modules;
    in
    {
      inherit mkHomeConfiguration;
      mkDarwinConfiguration =
        {
          username,
          brewUpgrade ? builtins.getEnv "HOMEBREW_UPGRADE" == "1",
          enableColima ? false,
          extraModules ? [ ],
          extraHomeManagerConfiguration ? { },
          ...
        }:
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit
              llm-agents
              brewUpgrade
              enableColima
              ;
          };
          modules = [
            (mkConfiguration { inherit username; })
            minimalModules
            nix-homebrew.darwinModules.nix-homebrew
            (mkHomeConfiguration {
              inherit home-manager;
              inherit username;
              extraConfig = extraHomeManagerConfiguration;
            })
          ]
          ++ extraModules;
        };
    };
}
