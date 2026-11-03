{
  mulib,
  host,
  ...
}:
mulib.module {
  name = "swayosd";

  options.enable = [host.feat.wm];

  home = {
    services.swayosd = {
      enable = true;
    };
  };
}
