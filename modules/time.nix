{ mulib, ... }:
mulib.module {
  name = "time";

  options.enable = mulib.bool.true;

  always.os = { myconfig, ... }: {
    time.timeZone = myconfig.constants.timeZone;
  };
}
