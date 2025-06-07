{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      # # autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      #
      # shellAliases = {
      #   ll = "ls -l";
      #   update = "sudo nixos-rebuild switch";
      # };
      # history.size = 10000;
    };
    # starship.enableZshIntegration = true;
  };
  environment.pathsToLink = [ "/share/zsh" ];

}
