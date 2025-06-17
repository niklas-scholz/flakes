{ ... }:
{
  programs = {
    zsh = {
      shellAliases = {
        pyac = "source $(poetry env info --path)/bin/activate";
      };
      sessionVariables = {
        FOO = "bar";
      };
    };
    pyenv = {
      enableZshIntegration = true;
    };
  };
}
