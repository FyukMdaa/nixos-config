# hosts/Inspiron14-5445/default.nix — Identity + base of the host
{mulib, ...}:
mulib.host {
  name = "Inspiron14-5445";
  system = "x86_64-linux";
  type = "laptop";
  feat = ["cli" "gui" "draw" "android-dev" "token2" "niri"];
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
      type = "amd";
    };
    powermanager = {
      enable = true;
      type = "auto-cpufreq";
    };
    emacs.enable = true;
  };
}
