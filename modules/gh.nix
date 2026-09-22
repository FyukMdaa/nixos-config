{ mulib, host, ... }:
mulib.module {
  name = "gh";

  options.enable = [ host.feat.cli ];

  home = {
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
  };
}
