{ mulib, host, pkgs, ... }:
mulib.module {
  name = "regreet";

  options.enable = [ host.feat.niri ];

  os = {
    services.displayManager.regreet = {
      enable = true;
      font = {
        package = pkgs.sf-pro;
        name = "SFProDisplay";
      };
      settings = {
        GTK = {
          application_prefer_dark_theme = true;
          cursor_theme_name = "Adwaita";
          icon_theme_name = "Adwaita";
          theme_name = "Adwaita";
        };
        command = {
          reboot = [ "systemctl" "reboot" ];
          poweroff = [ "systemctl" "poweroff" ];
        };
      };
    };
  };
}
