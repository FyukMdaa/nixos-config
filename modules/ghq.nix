{ mulib, host, pkgs, ... }:
mulib.module {
  name = "ghq";

  options.enable = [ host.feat.cli ];

  home = {
    home.packages = with pkgs; [ ghq ];
  };
}
