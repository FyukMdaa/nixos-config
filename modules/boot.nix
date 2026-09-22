{ mulib, lib, ... }:
mulib.module {
  name = "boot";

  options = {
    enable = mulib.bool.true;

    loader = lib.mkOption {
      type = lib.types.enum [ "systemd-boot" "grub" ];
      default = "systemd-boot";
    };
  };

  always.os = { opt, ... }: {
    boot = {
      loader = {
        systemd-boot = lib.mkIf (opt.loader == "systemd-boot") {
          enable = true;
          configurationLimit = 10;
        };
        grub = lib.mkIf (opt.loader == "grub") {
          enable = true;
          device = "nodev";
          efiSupport = true;
          configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
      };
      consoleLogLevel = 0;
      plymouth.enable = true;
    };
  };
}
