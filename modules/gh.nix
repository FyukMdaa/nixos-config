{ delib, ... }:
delib.module {
  name = "programs.gh";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  home.ifEnabled = { ... }: {
    programs.gh = {
      enable = true;

      settings = {
        git_protocol = "ssh";
      };
    };
  };
}
