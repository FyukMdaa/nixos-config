{ delib, ... }:
delib.module {
  name = "services.dbus";

  nixos.always = {
    services.dbus = {
      enable = true;
      implementation = "broker";
    };
  };
}
