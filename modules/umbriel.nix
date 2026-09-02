{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.umbriel";

  options = delib.moduleOptions (
    {myconfig, ...}: {
      enable = delib.boolOption myconfig.host.niriFeatured;
    }
  );

  nixos.always.imports = [inputs.umbriel.nixosModules.default];
  nixos.ifEnabled = {
    programs.umbriel.enable = true;
  };

  home.always.imports = [inputs.umbriel.homeModules.default];

  home.ifEnabled = {
    programs.umbriel = {
      enable = true;
      settings = {
        general = {
          autostart = ["fcitx5 -d &"];
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
