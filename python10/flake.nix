{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      # Create a function to generate a devShell for each supported system.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
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
        }
      );
    };
}
