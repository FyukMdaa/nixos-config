{ mulib, host, pkgs, ... }:
mulib.module {
  name = "nemo";

  options.enable = [ host.feat.gui ];

  os.environment.systemPackages = [ pkgs.nemo ];

  home = {
    home.packages = [ pkgs.nemo ];
  };
}
