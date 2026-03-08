{ pkgs, ... }:

let
  javascriptRuntimes = with pkgs; [
    nodejs
    deno
    bun
  ];

  pythonTools = with pkgs; [
    uv
  ];

  rustTools = with pkgs; [
    cargo
  ];

  infrastructureTools = with pkgs; [
    terraformer
    tenv
  ];

  databaseTools = with pkgs; [
    postgresql
  ];

  nixLinting = with pkgs; [
    statix
  ];
in
{
  environment.systemPackages =
    javascriptRuntimes
    ++ pythonTools
    ++ rustTools
    ++ infrastructureTools
    ++ databaseTools
    ++ nixLinting;
}
