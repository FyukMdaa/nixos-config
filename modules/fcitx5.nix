{
  mulib,
  pkgs,
  host,
  ...
}:
mulib.module {
  name = "fcitx5";

  options.enable = [host.feat.gui];

  os = {
    i18n = {
      inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          addons = with pkgs.stable; [
            fcitx5-gtk
            fcitx5-skk
            fcitx5-mozc
            fcitx5-nord
          ];
          waylandFrontend = true;
        };
      };
    };

    environment.systemPackages = with pkgs.skkDictionaries; [
      l
      jinmei
      fullname
      geo
      propernoun
      station
      law
      emoji
    ];
  };
}
