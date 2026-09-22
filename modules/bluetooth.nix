{ mulib, host, ... }:
mulib.module {
  name = "bluetooth";

  options.enable = [ host.type.laptop ];

  os = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };

    services.blueman.enable = true;
  };
}
