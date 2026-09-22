{ mulib, host, pkgs, ... }:
mulib.module {
  name = "keyroost";

  options.enable = [ host.feat.token2 ];

  home = {
    home.packages = with pkgs; [ keyroost ];
  };
}
