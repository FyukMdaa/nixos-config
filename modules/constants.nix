# modules/constants.nix — 全モジュールで共有する定数
#
# denix では myconfig.always で args.shared に送っていたが、
# mulix では options に宣言すれば自動的に myconfig.constants.X で読める。
{ mulib, ... }:
mulib.module {
  name = "constants";

  options = {
    enable = mulib.bool.true;

    username = mulib.str "fyukmdaa";
    userfullname = mulib.str "FyukMdaa";
    useremail = mulib.str "fyukmdaa@tutanota.com";
    mainLocale = mulib.str "ja_JP.UTF-8";

    screenshots = mulib.str "$HOME/Pictures/Screenshots";
    keyboardLayout = mulib.str "jp";
    keymap = mulib.str "jp106";
    keyboardVariant = mulib.str "";

    weather = mulib.str "Fukuoka";
    timeZone = mulib.str "Asia/Tokyo";
  };
}
