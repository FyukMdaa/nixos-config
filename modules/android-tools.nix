{ delib, pkgs, ... }:
delib.module {
  name = "programs.android-tools";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.android-devFeatured;
  });

  home.ifEnabled = { ... }: {
    home.packages = with pkgs; [
      android-tools
    ];
  };
}
