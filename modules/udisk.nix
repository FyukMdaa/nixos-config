{ mulib, ... }:
mulib.module {
  name = "udisk";

  options.enable = mulib.bool.true;

  always.os = {
    services.udisks2.enable = true;
  };

  always.home = {
    services.udiskie.enable = true;
  };
}
