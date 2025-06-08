{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.deno
    pkgs.bun
    pkgs.terraformer
    pkgs.pipx
    pkgs.nodejs
    pkgs.corepack
    pkgs.tenv
  ];
}
