{ delib, ... }:
delib.module {
  name = "programs.tealdeer";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  home.ifEnabled = { ... }: {
    programs.tealdeer = {
    	enable = true;
    	settings = {
    	  display = {
    	    use_pager = true;
    	    compact = false;
    	    show_title = true;
    	  };
    	  search = {
    	    languages = ["ja" "en"];
    	  };
    	  updates = {
    	    auto_update = true;
    	    download_languages = ["ja" "en"];
    	  };
    	};
    };
  };
}
