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

            users.users.niklasscholz.home = "/Users/niklasscholz";
            home-manager.backupFileExtension = "backup";

            home-manager.users.niklasscholz = {
              home.username = "niklasscholz";
              home.stateVersion = "25.05";
              home.enableNixpkgsReleaseCheck = false;
              programs = {
                zsh = {
                  enable = true;
                  enableCompletion = true;
                  autosuggestion.enable = true;
                  syntaxHighlighting.enable = true;
                  history.size = 10000;
                  oh-my-zsh = {
                    enable = true;
                    plugins = [
                      "git"
                    ];
                  };
                  sessionVariables = {
                    DELTA_PAGER = "less -R";
                    EDITOR = "nvim";

                  };

                  initContent = ''
                    bindkey '\eg' fzf-cd-widget
                  '';
                  shellAliases = {
                    vim = "nvim";
                    v = "nvim";
                    vi = "nvim";

                    t = "tmux";
                    ta = "t a";

                    cz = "chezmoi";

                    cat = "bat";

                    c = "clear";
                    e = "exit";

                    ls = "lsd";
                    du = "dust";
                    grep = "rg";
                    find = "fd";
                    lz = "lazygit";
                    cd = "z";
                  };

                };
                starship = {
                  enable = true;
                  enableZshIntegration = true;
                };
                fzf = {
                  enable = true;
                  enableZshIntegration = true;
                  defaultCommand = "fd --hidden --strip-cwd-prefix";
                  # Command line options for the CTRL-T keybinding.
                  fileWidgetCommand = "fd --hidden --strip-cwd-prefix";
                  # The command that gets executed as the source for skim for the ALT-C keybinding
                  changeDirWidgetCommand = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
                };
                zoxide = {
                  enable = true;
                  enableZshIntegration = true;
                };
                yazi = {
                  enable = true;
                  enableZshIntegration = true;
                };
              };
            };
          }
        ];
      };
      darwinConfigurations."MacBook-Pro-nik" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          ./hosts/work.nix
        ];
      };
    };
}
