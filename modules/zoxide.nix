{ mulib, host, ... }:
mulib.module {
  name = "zoxide";

  options.enable = [ host.feat.cli ];

  home = {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd z" ];
    };
  };
}
