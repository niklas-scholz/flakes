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

    # Required for touch ID authentication to work in tmux
    etc."pam.d/sudo_local".text = ''
      # Managed by Nix Darwin
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
    '';
  };

  homebrew = {
    enable = true; # Ensure homebrew is enabled
    casks = brewGuiApps;
  };
}
