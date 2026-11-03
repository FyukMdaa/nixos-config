{
  mulib,
  host,
  wmconfig,
  cmdname,
  inputs,
  ...
}:
mulib.module {
  name = "umbriel";

  options.enable = [(host.feat.wm) (wmconfig.name == "umbriel")];

  always = {
    os = {imports = [inputs.umbriel.nixosModules.default];};
    home = {imports = [inputs.umbriel.homeModules.default];};
  };

  os = {
    programs.umbriel.enable = true;
  };

  home = {
    programs.umbriel = {
      enable = true;
      settings = {
        general = {
          autostart = ["fcitx5 -d &"];
        };
        input.keyboard.layout = "jp";
        keybinds = {
          "Mod+Return" = "spawn:${cmdname.term}";
          "Mod+Q" = "window-close";
          "Mod+D" = "spawn:${cmdname.launcher}";
          "Mod+O" = "overview-toggle";
        };
      };
    };
  };
}
