{ mulib, host, ... }:
mulib.module {
  name = "swayosd";

  options.enable = [ [ host.feat.hyprland host.feat.niri ] ];

  home = {
    services.swayosd = {
      enable = true;
    };
  };
}
