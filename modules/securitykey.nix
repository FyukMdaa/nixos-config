{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "services.securtykey";

  options = delib.moduleOptions ({myconfig, ...}: {
    enable = delib.boolOption myconfig.host.token2Featured;
  });

  nixos.ifEnabled = {...}: {
    services.pcscd.enable = true;
    security.polkit.enable = true;
    security.pam.u2f = {
      enable = true;
      control = "sufficient";
    };
    security.pam.services.sudo.u2fAuth = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      pinentryPackage = pkgs.pinentry-emacs;
    };
    services.gnome = {
      gnome-keyring.enable = true;
      gcr-ssh-agent.enable = false;
    };
    environment.systemPackages = with pkgs; [
      libfido2
      pam_u2f
      opensc
      pcsclite
    ];
  };
  home.ifEnabled = {...}: {
    services.gnome-keyring = {
      enable = true;
      components = ["pkcs11" "secrets"];
    };
  };
}
