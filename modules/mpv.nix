{
  mulib,
  host,
  ...
}:
mulib.module {
  name = "mpv";

  options.enable = [host.feat.gui];

  home = {
    programs.mpv = {
      enable = true;
    };
  };
}
