{delib, ...}:
delib.module {
  name = "services.gnome-keyring";

  nixos.always = {
    services.gnome.gnome-keyring = {
      enable = true;
    };
    security.polkit.enable = true;
  };
}
