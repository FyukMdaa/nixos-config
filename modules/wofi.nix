{
  mulib,
  wmconfig,
  host,
  ...
}:
mulib.module {
  name = "wofi";

  options.enable = [(host.feat.wm) (wmconfig.launcher == "wofi")];

  home = {
    programs.wofi = {
      enable = true;
      settings = {
        width = 600;
        height = 400;
        location = "center";
        show = "drun";
        prompt = "Search...";
        filter_rate = 100;
        allow_markup = true;
        no_actions = true;
        halign = "fill";
        orientation = "vertical";
        content_halign = "fill";
        insensitive = true;
        allow_images = true;
        image_size = 40;
        gtk_dark = true;
      };

      style = ''
        * {
          font-family: "Noto Sans CJK JP", monospace;
          font-size: 14px;
        }

        window {
          margin: 0px;
          border: 2px solid #7dcfff;
          background-color: #1a1b26;
          border-radius: 8px;
        }

        #input {
          margin: 5px;
          border: 1px solid #414868;
          background-color: #24283b;
          color: #c0caf5;
          border-radius: 4px;
          padding: 8px;
        }

        #inner-box {
          margin: 5px;
          border: none;
          background-color: #1a1b26;
        }

        #outer-box {
          margin: 5px;
          border: none;
          background-color: #1a1b26;
        }

        #scroll {
          margin: 0px;
          border: none;
        }

        #text {
          margin: 5px;
          border: none;
          color: #c0caf5;
        }

        #entry:selected {
          background-color: #414868;
          border-radius: 4px;
        }

        #entry:selected #text {
          color: #7dcfff;
        }
      '';
    };
  };
  # derived contribution (Phase 2): ネストキーで書き込みpath (.launcher) を
  # 静的宣言したリーフ関数。値は wmconfig.launcher の宣言に追従し、
  # 依存グラフにも .launcher の書き込みpathが記録される。
  send.cmdname.launcher = {wmconfig, ...}: "${wmconfig.launcher} show drun";
}
