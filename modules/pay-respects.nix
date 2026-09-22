{ mulib, host, ... }:
mulib.module {
  name = "pay-respects";

  options.enable = [ host.feat.cli ];

  home = {
    programs.pay-respects = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
