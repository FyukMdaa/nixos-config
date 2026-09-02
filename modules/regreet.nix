{ delib, pkgs, ... }:
delib.module {
  name = "programs.regreet";

  options = delib.moduleOptions (
    { myconfig, ... }: {
      enable = delib.boolOption myconfig.host.niriFeatured;
    }
  );

  nixos.ifEnabled = {
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
          reboot = [
            "systemctl"
            "reboot"
          ];
          poweroff = [
            "systemctl"
            "poweroff"
          ];
        };
      };
    };
  };

}
