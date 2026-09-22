{ mulib, ... }:
mulib.host {
  name = "Inspiron14-5445";

  os = {
    systemd.services.systemd-machine-id-commit.enable = false;
    preservation = {
      enable = true;
      preserveAt."/persist" = {
        directories = [
          "/var/lib/nixos"
          "/var/lib/systemd"
          "/etc/NetworkManager/system-connections"
          "/etc/secureboot"
        ];
        files = [
          "/etc/machine-id"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
        ];
      };
    };
  };
}
