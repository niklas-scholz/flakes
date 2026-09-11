{
  pkgs,
  llm-agents,
  ...
}:

let
  searchTools = with pkgs; [
    ripgrep
    silver-searcher
    ack
    fd
    fzf
    tldr
  ];

  fileTools = with pkgs; [
    lsd
    tree
    yazi
    zoxide
    chezmoi
  ];

  networkTools = with pkgs; [
    curl
    wget
    httpie
  ];

  systemTools = with pkgs; [
    btop
    procs
    dust
  ];

  viewingTools = with pkgs; [
    bat
    less
    glow
    jq
  ];

  shellTools = with pkgs; [
    starship
  ];

  inherit (pkgs.stdenv.hostPlatform) system;

  aiTools = with llm-agents.packages.${system}; [
    claude-code
    pi
    opencode
  ];

  otherTools = with pkgs; [
    circumflex
  ];
in
{
  environment.systemPackages =
    searchTools
    ++ fileTools
    ++ networkTools
    ++ systemTools
    ++ viewingTools
    ++ shellTools
    ++ aiTools
    ++ otherTools;
}
