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
        pyac = pkgs.writeShellScriptBin "pyac" ''
          source $(poetry env info --path)/bin/activate
        '';
        mkPythonShell =
          {
            poetryVersion ? "",
            pythonPackage ? pkgs.python313,
          }:
          pkgs.mkShell {
            packages = [
              pythonPackage
              pkgs.pipx
              pyac
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
              echo "Installing poetry${
                # Optionally append the version string if provided
                if poetryVersion != "" then "==${poetryVersion}" else ""
              } into Nix-managed temporary environment..."

              pipx install poetry${
                # Append the version specification to the install command
                if poetryVersion != "" then "==${poetryVersion}" else ""
              }

              echo "Poetry is now available at: $(which poetry)"
            '';
          };
        devShell = mkPythonShell { };
      in
      {
        lib.mkPythonShell = mkPythonShell;

        devShells = {
          default = devShell;
        };
      }
    );
}
