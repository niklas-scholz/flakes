{
  ...
}:
{
  imports = [
    ./system
    ./packages
    ./fonts.nix
  ];

  homebrew = {
    enable = true;
  };
}
