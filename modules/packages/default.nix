{ pkgs, ... }:
{
  environment.systemPackages =
    (import ./cli-tools.nix { inherit pkgs; }) ++ (import ./dev-tools.nix { inherit pkgs; });

  homebrew = (import ./brew.nix { inherit pkgs; });

}
