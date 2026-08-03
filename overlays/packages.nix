{
  inputs,
  delib,
  ...
}:
delib.overlayModule {
  name = "pkgs-overlay";
  targets = [ "nixos" "home" ];
  overlays = [
    (final: _prev: {
      stable = import inputs.nixpkgs-stable {
        inherit (final) system;
        config.allowUnfree = true;
      };
    })
    (_final: prev: {
      lix = prev.lixPackageSets.stable;
    })
    (_final: prev: 
      inputs.apple-fonts.packages.${prev.stdenv.hostPlatform.system} or {}
    )
    inputs.hyprland.overlays.default
    inputs.hyprland.overlays.hyprland-packages
    inputs.floorp.overlays.default
    inputs.nix-cachyos-kernel.overlays.default
    inputs.fmpkgs.overlays.default
  ];
}
