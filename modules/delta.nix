{ mulib, host, ... }:
mulib.module {
  name = "delta";

  options.enable = [ host.feat.cli ];

  home = {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      enableJujutsuIntegration = true;
    };
  };
}
