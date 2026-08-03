{ delib, ... }:
delib.module {
  name = "programs.delta";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  home.ifEnabled = { ... }: {
    programs.delta = {
    	enable = true;
    	enableGitIntegration = true;
    	enableJujutsuIntegration = true;
    };
  };
}
