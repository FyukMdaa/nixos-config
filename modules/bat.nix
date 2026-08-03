{ delib, ... }:
delib.module {
  name = "programs.bat";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });
  
  home.ifEnabled = {
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
