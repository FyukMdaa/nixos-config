{mulib, ...}:
mulib.host {
  name = "home-lab";
  system = "x86_64-linux";
  type = "server";
  feat = ["cli"];
  role = ["workstation"];

  os = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "26.05";

    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PubkeyAuthentication = true;
      };
    };
    users.users.fyukmdaa.openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPZHuiQlgDv2bXHhmdtkYwrwxnbPPpk3qZmZRNX+xn3CnJWTwVGHmVinuNRSZUEsG2Q9iYTGL7gkPvy+CaJlP/s= PIV AUTH pubkey"
    ];
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
      type = "tlp";
    };
  };
}
