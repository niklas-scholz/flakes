## Python Development Shell Flake (Nix/Poetry)

This Nix Flake provides a **reusable library function** for creating isolated Python development environments that automatically set up **Poetry** using `pipx`. This ensures a clean, reproducible environment for any project using Poetry for dependency management.

---

### 🚀 Usage

#### Add the Flake as an Input for your project or shell

In your project's `flake.nix`, define this flake as an input (e.g., `python-shell-maker`):

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    python-shell-maker.url = "github:niklas-scholz/flakes/python";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      python-shell-maker,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:

      let
        pkgs = import nixpkgs { inherit system; };

        # Call the reusable function to create the shell:
        devShell = python-shell-maker.lib.${system}.mkPythonShell {
          # Optional parameters:
          # Specify Python version:
          pythonPackage = pkgs.python311;
          # Specify a fixed Poetry version:
          poetryVersion = "2.2.1";
        };
      in
      {
        devShells.default = devShell;
      }
    );
}
```
