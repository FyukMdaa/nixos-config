{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "services.securtykey";

  options = delib.moduleOptions ({myconfig, ...}: {
    enable = delib.boolOption myconfig.host.token2Featured;
  });

  nixos.ifEnabled = {myconfig, ...}: let
    inherit (myconfig.constants) username;

    pivHookScript = pkgs.writeShellScript "piv-ssh-hook" ''
      set -eu
      user="$1"
      unit="$2"
      uid=$(${pkgs.coreutils}/bin/id -u "$user")
      exec ${pkgs.util-linux}/bin/runuser -u "$user" -- \
        ${pkgs.coreutils}/bin/env \
        XDG_RUNTIME_DIR=/run/user/"$uid" \
        DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/"$uid"/bus \
        ${pkgs.systemd}/bin/systemctl --user --no-block start "$unit"
    '';
  in {
    # PC/SC デーモンの有効化
    services.pcscd.enable = true;

    # セキュリティ設定
    security.polkit.enable = true;

    # GnuPG / SSH 関連設定
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      pinentryPackage = pkgs.pinentry-all;
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

    # ユーザーの systemd インスタンスを常時起動 (ログインしてなくてもOK)
    users.users.${username}.linger = true;

    # Token2 抜き差しで ssh-agent へのキー登録/解除を自動化
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="349e", TAG+="uaccess", MODE="0660"
      KERNEL=="hidraw*", ATTRS{idVendor}=="349e", TAG+="uaccess", MODE="0660"

      ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="349e/*", \
        RUN+="${pivHookScript} ${username} piv-ssh-add.service"
      ACTION=="remove", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="349e/*", \
        RUN+="${pivHookScript} ${username} piv-ssh-remove.service"
    '';

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
    services.ssh-agent.enable = true;

    systemd.user.services.ssh-agent.Service.ExecStart =
      lib.mkForce
      "${pkgs.openssh}/bin/ssh-agent -D -a %t/ssh-agent -P '/run/current-system/sw/lib/*,/nix/store/*'";

    systemd.user.services.piv-ssh-add = {
      Unit.Description = "Add Token2 PIV key to ssh-agent";
      Service = {
        Type = "oneshot";
        Environment = [
          "SSH_AUTH_SOCK=%t/ssh-agent"
          "SSH_ASKPASS=${pkgs.seahorse}/libexec/seahorse/ssh-askpass"
          "SSH_ASKPASS_REQUIRE=force"
        ];
        ExecStart = "${pkgs.openssh}/bin/ssh-add -s /run/current-system/sw/lib/onepin-opensc-pkcs11.so";
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };

    systemd.user.services.piv-ssh-remove = {
      Unit.Description = "Remove Token2 PIV key from ssh-agent";
      Service = {
        Type = "oneshot";
        Environment = ["SSH_AUTH_SOCK=%t/ssh-agent"];
        ExecStart = "${pkgs.openssh}/bin/ssh-add -e /run/current-system/sw/lib/onepin-opensc-pkcs11.so";
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };

    services.gnome-keyring = {
      enable = true;
      components = ["secrets"];
    };
  };
}
