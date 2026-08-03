{ delib, pkgs, ... }:
delib.module {
  name = "programs.git";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  nixos.ifEnabled.environment.systemPackages = [pkgs.git];
  
  home.ifEnabled = { myconfig, ... }: {
    programs.git = {
      enable = true;
      lfs.enable = true;
      
      settings = {
      	user.name = myconfig.constants.username;
      	user.email = myconfig.constants.useremail;
      	pull.rebase = true;
      	push.autoSetupRemote = true;
      };
    };
  };

  myconfig.ifEnabled = {
    programs.zeno.snippets = [
      {
        name = "git add .";
        keyword = "Gad";
        snippet = "git add .";
      }
      {
	    name = "git commit";
	    keyword = "Gcm";
	    snippet = "git commit -m \"{{commit_message}}\"";
      }
      {
        name = "git push";
        keyword = "Gps";
        snippet = "git push";
      }
    ];
  };
}
