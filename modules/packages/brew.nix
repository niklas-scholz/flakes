{ pkgs }:
{
  enable = true;
  onActivation.cleanup = "uninstall";
  taps = [
    "nikitabobko/tap"
  ];
  brews = [
    "libtiff"
    "gdk-pixbuf"
    "git"
    "harfbuzz"
    "librsvg"
    "nvm"
    "pipx"
    "pnpm"
    "postgresql@14"
    "pyenv"
    "terraformer"
    "tfenv"
    "zsh"
    "zsh-syntax-highlighting"
    "oven-sh/bun/bun"
  ];
  casks = [
    "1password"
    "arc"
    "bettertouchtool"
    "canva"
    "dbeaver-community"
    "firefox"
    "font-fira-code"
    "ghostty"
    "gimp"
    "google-chrome"
    "imageoptim"
    "insomnia"
    "karabiner-elements"
    "keepassxc"
    "libreoffice"
    "nordvpn"
    "obsidian"
    "raycast"
    "spotify"
    "stretchly"
    "vlc"
    "whatsapp"
    "zoom"
  ];
}
