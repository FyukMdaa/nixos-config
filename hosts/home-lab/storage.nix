{ mulib, ... }:
mulib.host {
  name = "home-lab";

  os = {
    users.groups.media = { };
    users.users.fyukmdaa.extraGroups = [ "media" ];

    systemd.services.create-media-directories = {
      description = "Create shared media directories";
      requires = [ "srv-media.mount" ];
      after = [ "srv-media.mount" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        install -d -o fyukmdaa -g media -m 2770 /srv/media/files
        install -d -o fyukmdaa -g media -m 2750 /srv/media/photos
        install -d -o fyukmdaa -g media -m 2750 /srv/media/photos/library
        install -d -o fyukmdaa -g media -m 2750 /srv/media/videos
        install -d -o fyukmdaa -g media -m 2750 /srv/media/music
        install -d -o fyukmdaa -g media -m 2770 /srv/media/downloads
      '';
    };
  };
}
