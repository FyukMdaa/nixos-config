{
  mulib,
  pkgs,
  ...
}:
mulib.module {
  name = "udisk";

  options.enable = mulib.bool.true;

  always.os = {
    services.udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };

  always.home = {
    services.udiskie.enable = true;
    home.packages = with pkgs; [
      udiskie
      udisks
    ];
  };
}
