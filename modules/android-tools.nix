{ mulib, host, pkgs, ... }:
mulib.module {
  name = "android-tools";

  options.enable = [ host.feat.android-dev ];

  home = {
    home.packages = with pkgs; [ android-tools ];
  };
}
