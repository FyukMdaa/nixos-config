{ mulib, ... }:
mulib.module {
  name = "firmware";

  options.enable = mulib.bool.true;

  always.os = {
    hardware.enableRedistributableFirmware = true;
  };
}
