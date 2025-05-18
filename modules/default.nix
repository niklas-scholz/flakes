{ pkgs, ... }:
{
  imports = [
    ./system
    ./packages
  ];

  fonts.packages = [
    (pkgs.nerdfonts.override {
      fonts = [
        "FiraCode"
        "Meslo"
      ];
    })
  ];

}
