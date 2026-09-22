{ mulib, host, pkgs, ... }:
mulib.module {
  name = "dust";

  options.enable = [ host.feat.cli ];

  home = {
    home.packages = with pkgs; [ dust ];
  };
}
