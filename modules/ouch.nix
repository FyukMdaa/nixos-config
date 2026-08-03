{ delib, pkgs, ... }:
delib.module {
  name = "programs.ouch";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  home.ifEnabled = { ... }: {
    home.packages = with pkgs; [
      ouch
    ];
  };
}
