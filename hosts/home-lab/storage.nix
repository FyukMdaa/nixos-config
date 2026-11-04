{ mulib, ... }:
mulib.host {
  name = "home-lab";

  os = {
    users.groups.media = { };
    users.users.fyukmdaa.extraGroups = [ "media" ];

    systemd.tmpfiles.rules = [
      "d /srv/services 0711 root root - -"
      "d /srv/db 0711 root root - -"

      "d /srv/media/files 2770 fyukmdaa media - -"
      "d /srv/media/photos 2750 fyukmdaa media - -"
      "d /srv/media/photos/library 2750 fyukmdaa media - -"
      "d /srv/media/videos 2750 fyukmdaa media - -"
      "d /srv/media/music 2750 fyukmdaa media - -"
      "d /srv/media/downloads 2770 fyukmdaa media - -"
    ];
  };
}
