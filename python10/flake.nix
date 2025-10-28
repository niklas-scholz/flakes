{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:

      let
        pkgs = import nixpkgs {
          inherit system;
        };

        devShell = pkgs.mkShell {
          packages = [
            pkgs.python310
            pkgs.pipx
          ];

          shellHook = ''
            # 1. Create temporary directories inside a Nix-managed temporary space
            export PIPX_HOME="$(mktemp -d)"
            export PIPX_BIN_DIR="$PIPX_HOME/bin"

            # 2. Add the new bin directory to the shell's PATH
            export PATH="$PIPX_BIN_DIR:$PATH"

            # 3. Ensure pipx uses the new paths 
            ${pkgs.pipx}/bin/pipx ensurepath --force

            # 4. Install poetry
            echo "Installing poetry (1.5.1) into Nix-managed temporary environment..."
            pipx install poetry==1.5.1 

            echo "Poetry is now available at: $(which poetry)"
          '';
        };
      in
      {
        devShells = {
          default = devShell;
        };
      }
    );
}
