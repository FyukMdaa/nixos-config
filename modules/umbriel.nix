{ mulib, host, pkgs, inputs, ... }:
mulib.module {
  name = "umbriel";

  options.enable = [ host.feat.niri ];

  always.os = { imports = [ inputs.umbriel.nixosModules.default ]; };

  os = {
    programs.umbriel.enable = true;
  };

  always.home = { imports = [ inputs.umbriel.homeModules.default ]; };

  home = {
    programs.umbriel = {
      enable = true;
      settings = {
        general = {
          autostart = [ "fcitx5 -d &" ];
        };
        input.keyboard.layout = "jp";
        keybinds = {
          "Mod+Return" = "spawn:ghostty";
          "Mod+Q" = "window-close";
          "Mod+D" = "spawn:wofi --show drun";
          "Mod+O" = "overview-toggle";
        };
      };
    };
  };
}
