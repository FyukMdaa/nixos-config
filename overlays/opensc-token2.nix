# overlays/opensc-token2.nix — OpenSC overlay for Token2 PIN+ Series
{ mulib, inputs, ... }:
mulib.overlay {
  name = "opensc-token2-overlay";
  overlay = final: prev: {
    opensc = prev.opensc.overrideAttrs (old: rec {
      pname = "opensc";
      version = "git-63f21f4";

      src = final.fetchFromGitHub {
        owner = "OpenSC";
        repo = "OpenSC";
        rev = "63f21f4ad5b1e9d55e22afebc3254da24654b17a";
        hash = "sha256-aernIdjALHp5I0EAcUi3DfKKqRs1qt/r+cpdlf88EZA=";
      };

      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
        final.autoreconfHook
        final.pkg-config
      ];

      patches = builtins.filter
        (p: !(final.lib.hasInfix "CVE-2026-10275" (toString p)))
        (old.patches or [ ]);

      env = (old.env or { }) // {
        NIX_CFLAGS_COMPILE = (old.env.NIX_CFLAGS_COMPILE or "")
          + " -I${final.pcsclite.dev}/include/PCSC";
      };

      preConfigure = ''
        ${old.preConfigure or ""}
        ./bootstrap
      '';

      doCheck = false;
    });
  };
}
