{
  cleanupHomebrew ? false,
  ...
}:
{
  imports = [
    ./system
    ./packages
    ./fonts
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = if cleanupHomebrew then "unistall" else "none";
  };
}
