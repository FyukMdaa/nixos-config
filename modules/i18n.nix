{ mulib, ... }:
mulib.module {
  name = "i18n";

  options.enable = mulib.bool.true;

  always.os = { myconfig, ... }: {
    i18n.defaultLocale = myconfig.constants.mainLocale;
    console.keyMap = myconfig.constants.keymap;
  };
}
