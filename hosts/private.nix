{ pkgs, ... }:

{
  imports = [
    ../modules
  ];

  homebrew = {
    brews = [
      "oven-sh/bun/bun"
    ];
    casks = [
      "canva"
      "gimp"
      "keepassxc"
      "imageoptim"
      "insomnia"
      "libreoffice"
      "nordvpn"
      "spotify"
      "vlc"
      "whatsapp"
      "zoom"
    ];
  };

}
