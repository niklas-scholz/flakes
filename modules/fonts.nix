{ pkgs, ... }:
{
  fonts.packages = with pkgs.nerd-fonts; [
    fira-code
    meslo-lg
  ];
}
