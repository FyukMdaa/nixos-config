{ mulib, pkgs, lib, ... }:
mulib.module {
  name = "graphics";

  options = {
    enable = mulib.bool.true;

    type = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "amd" "nvidia" "intel" ]);
      default = null;
      description = "GPUの種類。nullの場合は基本設定のみ有効";
    };
  };

  os = { opt, ... }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = lib.mkIf (opt.type == "intel") (with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-compute-runtime
      ]);
    };

    hardware.amdgpu = lib.mkIf (opt.type == "amd") {
      opencl.enable = true;
      initrd.enable = true;
    };

    hardware.nvidia = lib.mkIf (opt.type == "nvidia") {
      modesetting.enable = true;
      nvidiaSettings = true;
    };

    services.xserver.videoDrivers = lib.mkIf (opt.type == "nvidia") [ "nvidia" ];
  };
}
