{ delib, pkgs, ... }:
delib.module {
  name = "programs.nemo";
  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.guiFeatured;
  });

  nixos.ifEnabled.environment.systemPackages = [pkgs.nemo];

  home.ifEnabled = {
    home.packages = [pkgs.nemo];
  };
}
