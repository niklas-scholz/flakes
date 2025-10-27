{
  # The inputs to our flake, including the Nixpkgs repository.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  # env = {
  #   # Set the default system for the flake.
  #   # defaultSystem = "x86_64-linux";
  #   PIPX_HOME = "$HOME/.local/pipx";
  # };

  # The outputs of our flake.
  outputs =
    { self, nixpkgs, ... }:
    let
      # Define the systems we want to support.
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
      # Define the development shells for our flake.
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          # The default development shell.
          default = pkgs.mkShell {
            # List the packages to include in the shell.
            packages = [
              pkgs.python310 # Explicitly specify Python 3.10
              pkgs.pipx # The pipx tool for installing and running Python applications in isolated environments
            ];

            # A hook that runs when you enter the development shell.
            # This ensures that pipx is correctly set up in the PATH.
            shellHook = ''
              # 1. Create temporary directories inside a Nix-managed temporary space
              export PIPX_HOME="$(mktemp -d)"
              export PIPX_BIN_DIR="$PIPX_HOME/bin"

              # 2. Add the new bin directory to the shell's PATH
              export PATH="$PIPX_BIN_DIR:$PATH"

              # 3. Ensure pipx uses the new paths (optional, but good practice)
              ${pkgs.pipx}/bin/pipx ensurepath --force

              # 4. Install poetry
              echo "Installing poetry (1.5.1) into Nix-managed temporary environment..."
              pipx install poetry==1.5.1 --verbose

              echo "Poetry is now available at: $(which poetry)"

              # Note: Since the directories are created with mktemp -d, they
              # will be automatically removed when the shell exits.
            '';
          };
        }
      );
    };
}
