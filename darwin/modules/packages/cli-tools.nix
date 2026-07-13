{
  pkgs,
  llm-agents,
  llm-agents-claude-code,
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

  aiTools = [
    llm-agents-claude-code.packages.${system}.claude-code
  ]
  ++ (with llm-agents.packages.${system}; [
    pi
    omp
    opencode
  ]);

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
