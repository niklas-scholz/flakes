{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      alacritty
      lazygit
      lazydocker
      neovim
      tmux
      devpod
      gh
      git
      k9s
      delta
      rainfrog
    ];

    # Required for touch ID authentication to work in tmux
    etc."pam.d/sudo_local".text = ''
      # Managed by Nix Darwin
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
    '';
  };

  homebrew = {
    casks = [
      "dbeaver-community"
      "ghostty"
      "visual-studio-code"
      "freelens"
    ];
  };
}
