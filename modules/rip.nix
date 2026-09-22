{ mulib, host, pkgs, ... }:
mulib.module {
  name = "rip";

  options.enable = [ host.feat.cli ];

  home = {
    home.packages = with pkgs; [ rip2 ];
  };
}
