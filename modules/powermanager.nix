{ mulib, lib, inputs, ... }:
mulib.module {
  name = "powermanager";

  options = {
    enable = mulib.bool.false;

    type = lib.mkOption {
      type = lib.types.enum [ "tlp" "auto-cpufreq" ];
      default = "tlp";
    };
  };

  always.os = { opt, ... }: {
    imports = [ inputs.auto-cpufreq.nixosModules.default ];

    services.power-profiles-daemon.enable =
      lib.mkIf opt.enable (lib.mkForce false);

    services.tlp = lib.mkIf (opt.enable && opt.type == "tlp") {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC    = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT   = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_DRIVER_OPMODE_ON_AC       = "active";
        CPU_DRIVER_OPMODE_ON_BAT      = "active";
        RUNTIME_PM_ON_AC              = "auto";
        RUNTIME_PM_ON_BAT             = "auto";
        USB_AUTOSUSPEND               = "1";
        WIFI_PWR_ON_BAT               = "on";
        SOUND_POWER_SAVE_ON_BAT       = "1";
        DISK_SPINDOWN_TIMEOUT_ON_BAT  = "600";
      };
    };

    programs.auto-cpufreq = lib.mkIf (opt.enable && opt.type == "auto-cpufreq") {
      enable = true;
      settings = {
        charger = { governor = "performance"; turbo = "auto"; };
        battery = { governor = "powersave"; turbo = "auto"; };
      };
    };
  };
}
