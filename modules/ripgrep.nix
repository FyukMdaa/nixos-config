{ mulib, host, ... }:
mulib.module {
  name = "ripgrep";

  options.enable = [ host.feat.cli ];

  home = {
    programs.ripgrep = {
      enable = true;
      arguments = [
        "--max-columns=150"
        "--max-columns-preview"
        "--glob=!.git/*"
        "--smart-case"
      ];
    };
  };
}
