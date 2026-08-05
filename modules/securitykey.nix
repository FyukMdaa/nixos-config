{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "services.securtykey";

  options = delib.moduleOptions ({myconfig, ...}: {
    enable = delib.boolOption myconfig.host.token2Featured;
  });

  nixos.ifEnabled = {...}: {
    # PC/SC デーモンの有効化
    services.pcscd.enable = true;

    # Token2 用 udev ルール
    services.udev.extraRules = ''
      # Token2 FIDO2 / PIN+ security keys (USB vendor 349e).
      # Grants the logged-in user access over CCID (PC/SC) and raw HID, no sudo needed.
      SUBSYSTEM=="usb", ATTRS{idVendor}=="349e", TAG+="uaccess", MODE="0660"
      KERNEL=="hidraw*", ATTRS{idVendor}=="349e", TAG+="uaccess", MODE="0660"
    '';

    # PAM & セキュリティ設定
    security.polkit.enable = true;
    security.pam = {
      u2f = {
        enable = true;
        control = "sufficient";
      };
    };
    security.pam.services.sudo.u2fAuth = true;

    # GnuPG / SSH 関連設定
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      pinentryPackage = pkgs.pinentry-emacs;
    };

    services.gnome = {
      gnome-keyring.enable = true;
      gcr-ssh-agent.enable = false;
    };

    # OpenSC から setcosだけを除外する
    environment.etc."opensc.conf".text = ''
      app default {
          card_drivers = skeid, dtrust, cardos, gemsafeV1, starcos, tcos, oberthur, authentic, iasecc, belpic, entersafe, epass2003, rutoken, rutoken_ecp, myeid, dnie, MaskTech, idprime, esteid2018, esteid2025, srbeid, coolkey, muscle, sc-hsm, PIV-II, cac, itacns, isoApplet, gids, openpgp, default;
      }
    '';

    programs.ssh = {
      startAgent = true;
      agentPKCS11Whitelist = "/nix/store/*,/run/current-system/sw/lib/*";
    };

    environment.systemPackages = with pkgs; [
      acsccid
      ccid
      libfido2
      pam_u2f
      opensc
      pcsclite
      pcsc-tools
      yubico-piv-tool
    ];
  };

  home.ifEnabled = {...}: {
    services.gnome-keyring = {
      enable = true;
      components = ["secrets"];
    };
  };
}
