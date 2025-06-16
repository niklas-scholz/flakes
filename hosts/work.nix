{ pkgs, ... }:

{
  imports = [
    ../modules
  ];

  environment.systemPackages = [
    pkgs.auth0-cli
    pkgs.pyenv
    pkgs.pipx
  ];

  homebrew = {
    brews = [ ];
    casks = [ ];
  };

}
