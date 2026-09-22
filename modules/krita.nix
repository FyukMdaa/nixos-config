{ mulib, host, pkgs, ... }:
mulib.module {
  name = "krita";

  options.enable = [ host.feat.draw ];

  home = {
    home.packages = with pkgs; [
      krita
      krita-plugin-gmic
    ];
  };
}
