{ pkgs, ... }:

{
  imports = [
    ../modules
  ];

  environment.systemPackages = [
    pkgs.pyenv
    pkgs.pipx
  ];

  homebrew = {
    brews = [ ];
    casks = [ ];
  };

}
