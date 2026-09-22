{ mulib, ... }:
mulib.host {
  name = "Inspiron14-5445";

  os = {
    disko.devices = {
      disk.main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                  crypttabExtraOpts = [ "tpm2-device=auto" ];
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [ "noatime" "compress=zstd:1" "ssd" "space_cache=v2" ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "noatime" "compress=zstd:1" "ssd" "space_cache=v2" ];
                    };
                    "@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "noatime" "compress=zstd:1" "ssd" "space_cache=v2" ];
                    };
                    "@log" = {
                      mountpoint = "/var/log";
                      mountOptions = [ "noatime" "compress=zstd:1" "ssd" "space_cache=v2" ];
                    };
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [ "noatime" "compress=zstd:1" "ssd" "space_cache=v2" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
