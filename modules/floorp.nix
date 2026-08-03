{ delib, inputs, ... }:
delib.module {
  name = "programs.floorp";
  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.guiFeatured;
  });
  home.always = {
    imports = [
      inputs.floorp.homeModules.floorp
    ];
  };
  home.ifEnabled = {
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
    programs.floorp-bin = {
      enable = true;
      natsumi = {
        enable = true;
        profiles = [ "13tdjlmq.default" ];
        append.enable = true;
      };
    };
  };
}
