{
  description = "Nik's minimal nix-darwin config library for shared use";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";
    # nix-homebrew's default brew-src predates the `command_wrapper` cask DSL
    # artifact, which the Homebrew JSON API now requires. Pin to a release that has it.
    nix-homebrew.inputs.brew-src.url = "github:Homebrew/brew/6.0.21";
    nix-homebrew.inputs.brew-src.flake = false;

    llm-agents.url = "github:numtide/llm-agents.nix/0948ef0098ceb7b909e01ad0151ce0077b25d435";

    # Pinned solely to keep claude-code at 2.1.197.
    llm-agents-claude-code.url = "github:numtide/llm-agents.nix/a56df1cdf52eac0b8aa255d8de09f7107a23bb2e";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      llm-agents,
      llm-agents-claude-code,
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
          specialArgs = { inherit llm-agents llm-agents-claude-code brewUpgrade enableColima; };
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
