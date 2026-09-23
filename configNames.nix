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
}
