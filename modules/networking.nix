{
  delib,
  host,
  ...
}:
delib.module {
  name = "networking";

  options.networking = with delib; {
    nameservers = listOfOption str [
      "1.1.1.1"
      "8.8.8.8"
    ];
    hosts = attrsOfOption (listOf str) { };
  };

  nixos.always =
    { cfg, myconfig, ... }:let
      inherit (myconfig.constants) username;
    in {
      networking = {
        hostName = host.name;

        firewall = {
          enable = true;
          allowedTCPPorts = [22];
        };

        networkmanager = {
          enable = true;
          dns = "default";
        };

        inherit (cfg) hosts nameservers;
      };

      # 一部のWi-Fiカードで必要
      hardware.usb-modeswitch.enable = true;

      users.users.${username}.extraGroups = [ "networkmanager" ];
    };
}

