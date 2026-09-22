{ mulib, pkgs, lib, ... }:
mulib.module {
  name = "kernel";

  options = {
    enable = mulib.bool.true;

    variant = lib.mkOption {
      type = lib.types.enum [
        "latest" "zen" "xanmod"
        "cachyos-latest" "cachyos-bore" "cachyos-deckify"
      ];
      default = "latest";
      description = "使用するカーネル";
    };

    useLTO = lib.mkEnableOption "Clang + ThinLTO（cachyos系のみ有効）" // { default = true; };

    archOpt = lib.mkOption {
      type = lib.types.enum [ "generic" "x86_64-v3" "x86_64-v4" "zen4" ];
      default = "generic";
      description = "アーキテクチャ最適化（LTO有効時のみ）";
    };
  };

  always.os = { opt, ... }: let
    isCachyos = lib.hasPrefix "cachyos" opt.variant;

    cachyosName =
      let
        base = "linux-${opt.variant}";
        ltoSfx = if opt.useLTO then "-lto" else "";
        archSfx =
          if opt.useLTO && opt.archOpt != "generic"
          then "-${opt.archOpt}"
          else "";
      in
        "${base}${ltoSfx}${archSfx}";

    cachyosPkg = pkgs.linuxPackagesFor pkgs.cachyosKernels.${cachyosName}
      or (throw "cachyos kernel not found: ${cachyosName}");

    nonCachyosPkg = {
      latest = pkgs.linuxPackages_latest;
      zen = pkgs.linuxPackages_zen;
      xanmod = pkgs.linuxPackages_xanmod_latest;
    }.${opt.variant};
  in {
    boot.kernelPackages =
      if isCachyos then cachyosPkg
      else nonCachyosPkg;
  };
}
