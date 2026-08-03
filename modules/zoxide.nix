{ delib, ... }:
delib.module {
  name = "programs.zoxide";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  home.ifEnabled = { ... }: {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd z"];
    };
  };
}
