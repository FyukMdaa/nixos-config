{ mulib, host, pkgs, ... }:
mulib.module {
  name = "ouch";

  options.enable = [ host.feat.cli ];

  home = {
    home.packages = with pkgs; [ ouch ];
  };
}
