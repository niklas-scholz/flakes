{ pkgs }:
{
  enable = true;
  onActivation.cleanup = "uninstall";
  taps = [
    "nikitabobko/tap"
  ];
  brews = [
    "git"
    "nvm"
    "pipx"
    "pnpm"
    "postgresql@14"
    "pyenv"
    "terraformer"
    "tfenv"
    "zsh"
    "zsh-syntax-highlighting"
  ];
  casks = [
    "1password"
    "arc"
    "aerospace"
    "bettertouchtool"
    "dbeaver-community"
    "firefox"
    "ghostty"
    "google-chrome"
    "karabiner-elements"
    "raycast"
    "stretchly"
    "obsidian"
  ];
}
