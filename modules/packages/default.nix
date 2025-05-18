{ pkgs, ... }:
{
  environment.systemPackages =
    (import ./cli-tools.nix { inherit pkgs; })
    ++ (import ./dev-tools.nix { inherit pkgs; })
    ++ (import ./macos-supercharge.nix { inherit pkgs; })
    ++ (import ./notes.nix { inherit pkgs; });

  homebrew = (import ./brew.nix { inherit pkgs; });

}
