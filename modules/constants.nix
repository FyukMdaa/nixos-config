{mulib, ...}:
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
  send.constants = {opt, ...}: {
    username = opt.username;
    userfullname = opt.userfullname;
    useremail = opt.useremail;
    mainLocale = opt.mainLocale;
    screenshots = opt.screenshots;
    keyboardLayout = opt.keyboardLayout;
    keymap = opt.keymap;
    keyboardVariant = opt.keyboardVariant;
    weather = opt.weather;
    timeZone = opt.timeZone;
  };
}
