{ delib, pkgs, ... }:
delib.module {
  name = "programs.krita";
  options = delib.moduleOptions ({ myconfig, ... }: {  
    enable = delib.boolOption myconfig.host.drawFeatured;  
  });

  home.ifEnabled = { ... }: {
    home.packages = with pkgs; [
      krita
      krita-plugin-gmic
    ];
  };
}
