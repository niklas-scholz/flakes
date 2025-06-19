{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    deno
    bun
    terraformer
    pipx
    nodejs
    corepack
    tenv
  ];
}
