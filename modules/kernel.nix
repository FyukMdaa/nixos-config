{
  mulib,
  pkgs,
  lib,
  ...
}:
mulib.module {
  name = "kernel";

  options = {
    enable = mulib.bool.true;

    variant = lib.mkOption {
      type = lib.types.enum [
        "latest"
        "zen"
        "xanmod"
      ];
      default = "latest";
      description = "使用するカーネル";
    };
  };

  always.os = {opt, ...}: let
    pkg =
      {
        latest = pkgs.linuxPackages_latest;
        zen = pkgs.linuxPackages_zen;
        xanmod = pkgs.linuxPackages_xanmod_latest;
      }.${
        opt.variant
      };
  in {
    boot.kernelPackages =
      pkg;
  };
}
