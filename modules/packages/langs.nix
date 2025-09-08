{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    deno
    bun
    terraformer
    pipx
    nodejs
    tenv
    nixfmt-rfc-style
  ];
}
