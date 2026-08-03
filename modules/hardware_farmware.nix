{ delib, ... }:
delib.module {
  name = "hardware.farmware";

  nixos.always = {
        hardware.enableRedistributableFirmware = true; 
  };
}
