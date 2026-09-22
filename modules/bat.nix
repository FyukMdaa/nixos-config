{ mulib, host, ... }:
mulib.module {
  name = "bat";

  options.enable = [ host.feat.cli ];

  home = {
    programs.bat = {
      enable = true;
      config = {
        theme = "ansi";
        style = "plain";
        pager = "less -FR";
      };
    };
  };
}
