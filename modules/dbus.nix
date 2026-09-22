{ mulib, ... }:
mulib.module {
  name = "dbus";

  options.enable = mulib.bool.true;

  always.os = {
    services.dbus = {
      enable = true;
      implementation = "broker";
    };
  };
}
