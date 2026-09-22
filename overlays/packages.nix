# overlays/packages.nix — nixpkgs overlays
#
# denix では delib.overlayModule で targets = ["nixos" "home"] を指定していたが、
# mulix では mulib.overlay 1つで全 module-system に適用される。
# (m.configurations が overlayModule として NixOS/HM に注入する)
{ mulib, inputs, lib, ... }:
mulib.overlay {
  name = "pkgs-overlay";
  overlay = lib.composeManyExtensions [
    (final: _prev: {
      stable = import inputs.nixpkgs-stable {
        inherit (final) system;
        config.allowUnfree = true;
      };
    })
    (_final: prev: {
      lix = prev.lixPackageSets.stable;
    })
    (
      _final: prev:
        inputs.apple-fonts.packages.${prev.stdenv.hostPlatform.system} or {}
    )
    inputs.floorp.overlays.default
    inputs.nix-cachyos-kernel.overlays.default
    inputs.fmpkgs.overlays.default
  ];
}
