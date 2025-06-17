{ ... }:
{
  programs = {
    zsh = {
      shellAliases = {
        pyac = "source $(poetry env info --path)/bin/activate";
      };
    };
    pyenv = {
      enableZshIntegration = true;
    };
  };
}
