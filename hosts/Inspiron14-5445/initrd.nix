{delib, ...}:
delib.host {
  name = "Inspiron14-5445";
  nixos.boot.initrd = {
    systemd = {
      enable = true;
      services.btrfs-rollback = {
        description = "Rollback Btrfs root subvolume";
        wantedBy = ["initrd.target"];
        after = ["systemd-cryptsetup@crypted.service"]; # LUKS解錠後に実行
        before = ["sysroot.mount"]; # / のマウント直前に実行
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";

        script = ''
          mkdir -p /tmp/btrfs-root
          mount -o subvolid=5 /dev/mapper/crypted /tmp/btrfs-root

          if [ -e /tmp/btrfs-root/@root ]; then
            # 消す前に前回のルートを退避
            # btrfs subvolume snapshot /tmp/btrfs-root/@root /tmp/btrfs-root/@root-old

            btrfs subvolume delete /tmp/btrfs-root/@root
          fi

          btrfs subvolume create /tmp/btrfs-root/@root
          umount /tmp/btrfs-root
        '';
      };
    };
  };
}
