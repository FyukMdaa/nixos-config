{ mulib, host, ... }:
mulib.module {
  name = "open-tablet-driver";

  options.enable = [ host.feat.draw ];

  os = {
    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];
  };
}
