{ mulib, host, ... }:
mulib.module {
  name = "fd";

  options.enable = [ host.feat.cli ];

  home = {
    programs.fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/"
        "node_modules/"
      ];
    };
  };
}
