{ mulib, modulesPath, ... }:
mulib.host {
  name = "home-lab";

  os = {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
      initrd.availableKernelModules = [
        "nvme"
        "ahci"       # sda/sdb/sdc(SATA)をinitrdで復号するために必要
        "xhci_pci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      initrd.kernelModules = [ ];
      kernelModules = [ "kvm-intel" ];
      extraModulePackages = [ ];
    };

    # メモリが少ないのでディスクswapは使わずzram運用(modules/zram.nixが既定で有効)
    swapDevices = [ ];

    hardware.facter.reportPath = ./facter.json;
  };
}
