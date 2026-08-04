{
  delib,
  lib,
  pkgs,
  ...
}:
delib.host {
  name = "Inspiron14-5445";

  nixos = {
    # modules/boot.nixが systemd-boot.enable = true を入れるので上書きする
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot"; # 署名鍵の置き場所
    };

    environment.systemPackages = [pkgs.stable.sbctl];
  };
}
