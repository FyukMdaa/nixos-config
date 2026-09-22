{ mulib, host, lib, ... }:
mulib.module {
  name = "networking";

  options = {
    enable = mulib.bool.true;

    nameservers = mulib.listOf mulib.type.str [ "1.1.1.1" "8.8.8.8" ];
    hosts = lib.mkOption {
      type = lib.types.attrsOf (lib.types.listOf lib.types.str);
      default = { };
    };
  };

  always.os = { opt, myconfig, ... }: let
    inherit (myconfig.constants) username;
  in {
    networking = {
      hostName = host.name;

      firewall = {
        enable = true;
        allowedTCPPorts = [ 22 ];
      };

      networkmanager = {
        enable = true;
        dns = "default";
      };

      inherit (opt) hosts nameservers;
    };

    hardware.usb-modeswitch.enable = true;

    users.users.${username}.extraGroups = [ "networkmanager" ];
  };
}
