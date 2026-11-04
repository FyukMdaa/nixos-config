{ mulib, ... }:
mulib.host {
  name = "home-lab";

  os = {
    disko.devices = {
      disk = {
        # --- root: nvme0n1 ---
        main = {
          type = "disk";
          device = "/dev/disk/by-id/nvme-SAMSUNG_MZAL4512HBLU-00BL2_S67MNF0W157708";
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

        # --- データミラー用SSD 2台 ---
        # sdcは先に定義(sda側のmkfs.btrfsからraid1メンバーとして参照されるため)
        data0 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-KIOXIA-EXCERIA_SATA_SSD_323B711TKFY2";
          content = {
            type = "gpt";
            partitions = {
              data = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "cryptdata2";
                  settings = {
                    allowDiscards = true;
                    crypttabExtraOpts = [ "tpm2-device=auto" ];
                  };
                  # btrfsはここでは作らない(data1側でraid1メンバーとして渡す)
                };
              };
            };
          };
        };

        data1 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-Crucial_CT525MX300SSD1_16411438C5FE";
          content = {
            type = "gpt";
            partitions = {
              data = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "cryptdata1";
                  settings = {
                    allowDiscards = true;
                    crypttabExtraOpts = [ "tpm2-device=auto" ];
                  };
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" "-m raid1 -d raid1" "/dev/mapper/cryptdata2" ];
                    subvolumes = {
                      # Existing empty subvolume; repurposed as the shared service-state mount.
                      "@nextcloud" = {
                        mountpoint = "/srv/services";
                        mountOptions = [ "noatime" "compress=zstd:1" "ssd" "space_cache=v2" ];
                      };
                      # Existing empty subvolume; repurposed for database storage.
                      "@immich" = {
                        mountpoint = "/srv/db";
                        mountOptions = [ "noatime" "compress=zstd:1" "ssd" "space_cache=v2" ];
                      };
                    };
                  };
                };
              };
            };
          };
        };

        # --- HDD: 大容量/バックアップ ---
        hdd = {
          type = "disk";
          device = "/dev/disk/by-id/ata-ST2000DM006-2DM164_W4Z4B0GZ";
          content = {
            type = "gpt";
            partitions = {
              data = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "crypthdd";
                  settings = {
                    crypttabExtraOpts = [ "tpm2-device=auto" ];
                  };
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "@media" = {
                        mountpoint = "/srv/media";
                        mountOptions = [ "noatime" "compress=zstd:1" ];
                      };
                      "@backup" = {
                        mountpoint = "/srv/backup";
                        mountOptions = [ "noatime" "compress=zstd:1" ];
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
  };
}
