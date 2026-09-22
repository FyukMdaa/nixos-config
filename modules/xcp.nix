{ mulib, host, pkgs, ... }:
mulib.module {
  name = "xcp";

  options.enable = [ host.feat.cli ];

  home = {
    home.packages = with pkgs; [ xcp ];
  };
}
