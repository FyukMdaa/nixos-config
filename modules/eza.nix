{ delib, ... }:
delib.module {
  name = "programs.eza";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });
  
  home.ifEnabled = {
  	programs.eza = {
  	  enable = true;
  	  enableZshIntegration = true;
  	  git = true;
  	  icons = "auto";
  	};
  };
}
