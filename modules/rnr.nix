{ mulib, host, pkgs, ... }:
mulib.module {
  name = "rnr";

  options.enable = [ host.feat.cli ];

  home = {
    home.packages = with pkgs; [ rnr ];
  };
}
