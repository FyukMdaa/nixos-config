# configNames.nix — mulix configName registry
#
# denix の myconfig.ifEnabled で他 module の option に書き込んでいたパターンを
# mulix では configName + send で表現する。
{ lib, ... }:

{
  myconfig = {
    bind = "mulix.modules";
  };
  
  # zeno スニペット: 複数 module がリストを連結する
  # denix では myconfig.ifEnabled = { programs.zeno.snippets = [...]; } だった
  zenoSnippets = {
    type = lib.types.listOf lib.types.attrs;
    merge = "ordered";
    default = [ ];
  };
}
