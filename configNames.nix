{lib, ...}: {
  myconfig = {
    bind = "mulix.modules";
  };
  constants = {
    type = lib.types.attrs;
    merge = "single";
    default = {};
  };
  zenoSnippets = {
    type = lib.types.listOf lib.types.attrs;
    merge = "ordered";
    default = [];
  };
  zeno = {
    type = lib.types.attrs;
    merge = "single";
    default = {};
  };
  cmdname = {
    type = lib.types.attrs;
    merge = "single";
    default = {};
  };
  wmconfig = {
    type = lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.enum ["niri" "umbriel"];
          default = "niri";
        };
        launcher = lib.mkOption {
          type = lib.types.enum ["wofi"];
          default = "wofi";
        };
        term = lib.mkOption {
          type = lib.types.enum ["ghostty"];
          default = "ghostty";
        };
      };
    };
    merge = "single";
    default = {
      name = "niri";
      launcher = "wofi";
      term = "ghostty";
    }; # {} ではなく全項目を明示
  };
}
