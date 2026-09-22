{ mulib, host, ... }:
mulib.module {
  name = "eza";

  options.enable = [ host.feat.cli ];

  home = {
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };
  };
}
