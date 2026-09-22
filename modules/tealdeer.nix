{ mulib, host, ... }:
mulib.module {
  name = "tealdeer";

  options.enable = [ host.feat.cli ];

  home = {
    programs.tealdeer = {
      enable = true;
      settings = {
        display = {
          use_pager = true;
          compact = false;
          show_title = true;
        };
        search = {
          languages = [ "ja" "en" ];
        };
        updates = {
          auto_update = true;
          download_languages = [ "ja" "en" ];
        };
      };
    };
  };
}
