{ username, ... }:
{
  home.username = username;
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;
  programs = import ./shell.nix // {
    # ...
  };
}
