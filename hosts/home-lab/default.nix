{mulib, ...}:
mulib.host {
  name = "home-lab";
  system = "x86_64-linux";
  type = "server";
  feat = ["cli" "gui" "token2" "niri"];
  role = ["workstation"];

  os = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "26.05";
  };

  home = {
    home.stateVersion = "26.05";
  };

  send.force.myconfig = {
    boot.loader = "systemd-boot";
    kernel.variant = "latest";
    graphics = {
      enable = true;
      type = "nvidia-legacy";
    };
    powermanager = {
      enable = true;
      type = "auto-cpufreq";
    };
    zram.zramPercent = 75;
  };
}
