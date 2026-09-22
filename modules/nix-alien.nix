{ mulib, host, inputs, lib, pkgs, ... }:
mulib.module {
  name = "nix-alien";

  options.enable = mulib.bool.false;

  os = {
    programs.nix-ld.enable = lib.mkForce true;

    environment.systemPackages = [
      inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}.nix-alien
    ];
  };
}
