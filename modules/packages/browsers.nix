{ pkgs, ... }:
{
  homebrew = {
    casks = [
      "arc"
      "firefox"
      "firefox@developer-edition"
      "google-chrome"
      "zen"
    ];
  };
}
