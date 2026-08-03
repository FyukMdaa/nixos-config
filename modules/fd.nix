{ delib, ... }:
delib.module {
  name = "programs.fd";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });
  
  home.ifEnabled = {
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
