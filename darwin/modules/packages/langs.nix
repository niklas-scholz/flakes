{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    deno
    bun
    terraformer
    nodejs
    tenv
    cargo
    nixfmt-rfc-style
  ];
}
