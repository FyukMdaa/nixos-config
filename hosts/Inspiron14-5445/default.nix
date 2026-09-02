{delib, ...}:
delib.host {
  name = "Inspiron14-5445";

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "26.05";

  nixos = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "26.05";
  };

  type = "laptop";
  features = [
    "cli"
    "gui"
    "draw"
    "android-dev"
    "token2"
    "niri"
  ];

  shared.myconfig = {
    boot.loader = "systemd-boot";
    kernel = {
      variant = "latest";
      # useLTO    = true;
      # archOpt   = "zen4";
    };
    graphics = {
      enable = true;
      type = "amd";
    };
    powermanager = {
      enable = true;
      type = "auto-cpufreq";
    };
    programs = {
      emacs.enable = true;
    };
  };
}
