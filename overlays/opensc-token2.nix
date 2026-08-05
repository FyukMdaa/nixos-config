{
  inputs,
  delib,
  ...
}:
delib.overlayModule {
  name = "opensc-token2-overlay";
  targets = [ "nixos" "home" ];
  overlays = [
    (final: prev: {
      # OpenSC を PR #3673 マージ済みの master からビルド。
      # Token2 PIN+ Series が PIV_II / OpenPGP card の間で
      # フラッピングする問題 (Issue #3545) の修正を含む。
      # https://github.com/OpenSC/OpenSC/issues/3545
      # https://github.com/OpenSC/OpenSC/pull/3673
      opensc = prev.opensc.overrideAttrs (old: rec {
        pname = "opensc";
        # PR #3673 は 2026-05-21 に master へマージ (commit 63f21f4)。
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

        # 開発版のため、CI依存のテストは無効化
        doCheck = false;
      });
    })
  ];
}
