{ pkgs, ... }:

{
  imports = [
    ../modules
  ];

  homebrew = {
    brews = [ ];
    casks = [ "slack" ];
  };

}
