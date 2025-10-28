{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    deno
    bun
    terraformer
    nodejs
    tenv
    nixfmt-rfc-style
  ];
}
