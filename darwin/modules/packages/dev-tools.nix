{ pkgs, ... }:

let
  terminalTools = with pkgs; [
    alacritty
    tmux
  ];

  gitTools = with pkgs; [
    git
    gh
    lazygit
    delta
  ];

  devOpsTools = with pkgs; [
    lazydocker
    devpod
    k9s
  ];

  editorTools = with pkgs; [
    neovim
  ];

  dbTools = with pkgs; [
    rainfrog
  ];

  brewGuiApps = [
    "dbeaver-community"
    "ghostty"
    "visual-studio-code"
    "kitty"
    "freelens"
  ];
in
{
  environment = {
    systemPackages = terminalTools ++ gitTools ++ devOpsTools ++ editorTools ++ dbTools;
  };

  homebrew = {
    enable = true; # Ensure homebrew is enabled
    casks = brewGuiApps;
  };
}
