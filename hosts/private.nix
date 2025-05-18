{ pkgs, ... }:

{
  imports = [
    ../modules
  ];

  homebrew = {
    brews = [ "cowsay" ];
  };

}
