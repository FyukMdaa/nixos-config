{ delib, ... }:
delib.module {
  name = "programs.jujutsu";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  home.ifEnabled = { myconfig, ... }: {
    programs.jujutsu = {
      enable = true;
      
      settings = {
      	user.name = myconfig.constants.username;
      	user.email = myconfig.constants.useremail;
      };
    };
  };
}
