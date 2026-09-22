{ mulib, host, ... }:
mulib.module {
  name = "jujutsu";

  options.enable = [ host.feat.cli ];

  home = { myconfig, ... }: {
    programs.jujutsu = {
      enable = true;

      settings = {
        user.name = myconfig.constants.username;
        user.email = myconfig.constants.useremail;
      };
    };
  };
}
