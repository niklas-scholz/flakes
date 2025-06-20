{
  cleanupHomebrew ? false,
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
    onActivation.cleanup = if cleanupHomebrew then "uninstall" else "none";
  };
}
