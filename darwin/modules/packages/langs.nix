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

  nixTools = with pkgs; [
    statix
    nixfmt-rfc-style
  ];
in
{
  environment.systemPackages =
    javascriptRuntimes ++ pythonTools ++ rustTools ++ infrastructureTools ++ databaseTools ++ nixTools;
}
