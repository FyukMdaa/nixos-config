{
  disko.devices = {
    disk = {
      main = {
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
                mountOptions = ["umask=0077"];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true; # SSDのTRIMを有効化
                };
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    # ルート（起動ごとに消去される）
                    "@root" = {
                      mountpoint = "/";
                      mountoptions = ["noatime" "compress=zstd:1" "ssd" "space_cache=v2"];
                    };
                    # Nix Store（永続化）
                    "@nix" = {
                      mountpoint = "/nix";
                      mountoptions = ["noatime" "compress=zstd:1" "ssd" "space_cache=v2"];
                    };
                    # Preservation 永続化データ置き場
                    "@persist" = {
                      mountpoint = "/persist";
                      mountoptions = ["noatime" "compress=zstd:1" "ssd" "space_cache=v2"];
                    };
                    # システムログ（トラブルシューティング用）
                    "@log" = {
                      mountpoint = "/var/log";
                      mountoptions = ["noatime" "compress=zstd:1" "ssd" "space_cache=v2"];
                    };
                    # home 
                    "@home" = {
                      mountpoint = "/home";
                      mountoptions = ["noatime" "compress=zstd:1" "ssd" "space_cache=v2"];
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
