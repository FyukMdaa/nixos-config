{
  mulib,
  host,
  ...
}:
mulib.module {
  name = "discord";

  options.enable = [host.feat.gui];

  home = {
    programs.discord = {
      enable = true;
    };
  };
}
