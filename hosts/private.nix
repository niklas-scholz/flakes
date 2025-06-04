{ pkgs, ... }:

{
  imports = [
    ../modules
  ];

  homebrew = {
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
