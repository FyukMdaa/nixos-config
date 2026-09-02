{delib, ...}:
delib.module {
  name = "programs.swayosd";
  options = delib.moduleOptions ({myconfig, ...}: {
    enable = delib.boolOption (myconfig.host.hyprlandFeatured || myconfig.host.niriFeatured);
  });

  home.ifEnabled = {
    services.swayosd = {
      enable = true;
    };
  };
}
