{ mulib, host, inputs, ... }:
mulib.module {
  name = "floorp";

  options.enable = [ host.feat.gui ];

  always.home = {
    imports = [ inputs.floorp.homeModules.floorp ];
  };

  home = {
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
