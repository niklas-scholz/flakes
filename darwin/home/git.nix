{ ... }:
{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = false;
    };
  };

  programs.git = {
    enable = true;

    ignores = [
      "**/.claude/settings.local.json"
      ".plans/"
    ];

    lfs.enable = true;

    settings = {
      alias.dm = "diff main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      merge = {
        conflictstyle = "diff3";
        tool = "nvimdiff";
      };
      diff.colorMoved = "default";
      mergetool = {
        keepBackup = false;
        prompt = false;
      };
      "mergetool \"nvimdiff\"".cmd =
        "nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
    };
  };
}
