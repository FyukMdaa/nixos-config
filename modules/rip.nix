{ delib, pkgs, ... }:
delib.module {
  name = "programs.rip";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  home.ifEnabled = { ... }: {
    home.packages = with pkgs; [
      rip2
    ];
  };
}
