{ mulib, modulesPath, ... }:
mulib.host {
  name = "Inspiron14-5445";

  os = {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
      initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      initrd.kernelModules = [ ];
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };

    swapDevices = [ ];

    hardware.facter.reportPath = ./facter.json;
  };
}
