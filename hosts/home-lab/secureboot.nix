{ mulib, lib, pkgs, ... }:
mulib.host {
  name = "home-lab";

  os = {
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    environment.systemPackages = [ pkgs.stable.sbctl ];
  };
}
