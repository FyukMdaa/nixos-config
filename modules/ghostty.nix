{
  mulib,
  host,
  pkgs,
  ...
}:
mulib.module {
  name = "ghostty";

  options.enable = [host.feat.gui];

  home = {
    home.packages = [pkgs.ghostty];
  };

  # derived contribution (Phase 2): 全体関数 send ではなくネストキー
  # (.term) で書き込みpathを静的宣言する。依存グラフの詳細に
  # 「writes [.term]」が記録され、自己フィード規則の恩恵も受けられる。
  send.cmdname.term = {wmconfig, ...}:
    mulib.select wmconfig.term {
      "ghostty" = "ghostty";
    };
}
