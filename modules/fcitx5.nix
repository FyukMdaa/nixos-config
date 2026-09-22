{ mulib, pkgs, ... }:
mulib.module {
  name = "fcitx5";

  options.enable = mulib.bool.true;

  os = {
    i18n = {
      inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          addons = with pkgs; [
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
