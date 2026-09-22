{ mulib, host, pkgs, ... }:
mulib.module {
  name = "yazi";

  options.enable = [ host.feat.cli ];

  home = {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        mgr = {
          show_hidden = true;
          sort_dir_first = true;
        };
      };
      plugins = with pkgs.yaziPlugins; {
        git = git;
        piper = piper;
        ouch = ouch;
        rich-preview = rich-preview;
        jump-to-char = jump-to-char;
        mount = mount;
        restore = restore;
        gvfs = gvfs;
        yafg = yafg;
      };
      keymap = {
        mgr.prepend_keymap = [
          {
            on = "s";
            run = "plugin jump-to-char";
            desc = "Jump to char";
          }
          {
            on = "C";
            run = "plugin ouch";
            desc = "Compress with ouch";
          }
        ];
      };
    };
  };
}
