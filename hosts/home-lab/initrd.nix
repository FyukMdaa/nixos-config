{ mulib, ... }:
mulib.host {
  name = "home-lab";

  os.boot.initrd = {
    systemd = {
      enable = true;
      services.btrfs-rollback = {
        description = "Rollback Btrfs root subvolume";
        wantedBy = ["initrd.target"];
        after = ["systemd-cryptsetup@crypted.service"];
        before = ["sysroot.mount"];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";

        script = ''
          mkdir -p /tmp/btrfs-root
          mount -o subvolid=5 /dev/mapper/crypted /tmp/btrfs-root

          if [ -e /tmp/btrfs-root/@root ]; then
            btrfs subvolume delete /tmp/btrfs-root/@root
          fi

          btrfs subvolume create /tmp/btrfs-root/@root
          umount /tmp/btrfs-root
        '';
      };
    };
  };
}
