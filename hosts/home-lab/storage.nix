{ mulib, ... }:
mulib.host {
  name = "home-lab";

  os = {
    # Shared group for user-managed media libraries. Service users can be added
    # to this group when the corresponding services are enabled.
    users.groups.media = { };
    users.users.fyukmdaa.extraGroups = [ "media" ];

    systemd.tmpfiles.rules = [
      # SSD Btrfs subvolume mount points. Keep their parent directories
      # traversable; individual services own their private subdirectories.
      "d /srv/services 0711 root root - -"
      "d /srv/db 0711 root root - -"

      # HDD shared libraries. The setgid bit keeps newly-created files in
      # the media group. The library directories are group-readable, while
      # files/ and downloads/ are group-writable.
      "d /srv/media/files 2770 fyukmdaa media - -"
      "d /srv/media/photos 2750 fyukmdaa media - -"
      "d /srv/media/photos/library 2750 fyukmdaa media - -"
      "d /srv/media/videos 2750 fyukmdaa media - -"
      "d /srv/media/music 2750 fyukmdaa media - -"
      "d /srv/media/downloads 2770 fyukmdaa media - -"
    ];
  };
}
