{ mulib, host, pkgs, ... }:
mulib.module {
  name = "ghostty";

  options.enable = [ host.feat.gui ];

  home = {
    home.packages = [ pkgs.ghostty ];
  };
}
