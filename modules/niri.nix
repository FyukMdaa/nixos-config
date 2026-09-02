{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.niri";

  options = delib.moduleOptions (
    {myconfig, ...}: {
      enable = delib.boolOption myconfig.host.niriFeatured;
    }
  );

  nixos.ifEnabled = {
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [
      nirius
      nirimon
    ];
  };

  home.ifEnabled = {
    wayland.windowManager.niri = {
      enable = true;
      settings = {
        environment = {
          NIXOS_OZONE_WL = "1";
          MOZ_ENABLE_WAYLAND = "1";
          GTK_IM_MODULE = "fcitx";
          QT_IM_MODULE = "fcitx";
          XMODIFIERS = "@im=fcitx";
          QT_QPA_PLATFORM = "wayland";
          XDG_CURRENT_DESKTOP = "niri";
          XDG_SESSION_TYPE = "wayland";
        };

        input = {
          keyboard.xkb = {
            layout = "jp";
          };

          touchpad = {
            tap = {};
            natural-scroll = {};
            dwt = {};
            accel-speed = 0.2;
          };

          mouse = {
            accel-speed = 0.0;
            accel-profile = "flat";
          };
        };

        layout = {
          always-center-single-column = {};
          gaps = 8;
          border = {
            width = 2;
            active-color = "#7fc8ff";
            inactive-color = "#505050";
          };
          focus-ring.off = {};
          default-column-width._children = [
            {proportion = 0.5;}
          ];

          preset-column-widths._children = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
          ];
        };

        binds = {
          # アプリ起動
          "Mod+Return" = {
            _props.hotkey-overlay-title = "Open a Terminal";
            spawn = ["ghostty"];
          };
          "Mod+D" = {
            _props.hotkey-overlay-title = "run wofi";
            spawn = ["wofi" "show" "drun"];
          };

          "Mod+Q".close-window = {};
          "Mod+Shift+E".quit = {};
          "Mod+O".toggle-overview = {};

          # フォーカス移動
          "Mod+H".focus-column-left = {};
          "Mod+L".focus-column-right = {};
          "Mod+J".focus-window-or-workspace-down = {};
          "Mod+K".focus-window-or-workspace-up = {};
          # カラム移動
          "Mod+Shift+H".move-column-left = {};
          "Mod+Shift+L".move-column-right = {};
          "Mod+Shift+J".move-window-down-or-to-workspace-down = {};
          "Mod+Shift+K".move-window-up-or-to-workspace-up = {};
          # モニターフォーカス移動
          "Mod+Ctrl+H".focus-monitor-left = {};
          "Mod+Ctrl+L".focus-monitor-right = {};
          "Mod+Ctrl+J".focus-monitor-down = {};
          "Mod+Ctrl+K".focus-monitor-up = {};
          # モニターワークスペース移動
          "Mod+Shift+Ctrl+H".move-column-to-monitor-left = {};
          "Mod+Shift+Ctrl+L".move-column-to-monitor-right = {};
          "Mod+Shift+Ctrl+J".move-column-to-monitor-down = {};
          "Mod+Shift+Ctrl+K".move-column-to-monitor-up = {};

          # サイズ・レイアウト調整
          "Mod+N".switch-preset-column-width = {};
          "Mod+M".maximize-column = {};
          "Mod+Shift+M".fullscreen-window = {};
          "Mod+F".toggle-window-floating = {};

          # ワークスペース操作
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;

          # スクリーンショット
          "Print".screenshot = {};
          "Ctrl+Print".screenshot-screen = {};

          # 音量・輝度（ロック中でも効くように）
          "XF86AudioRaiseVolume" = {
            _props.allow-when-locked = true;
            spawn = ["swayosd-client" "--output-volume" "raise"];
          };
          "XF86AudioLowerVolume" = {
            _props.allow-when-locked = true;
            spawn = ["swayosd-client" "--output-volume" "lower"];
          };
          "XF86AudioMute" = {
            _props.allow-when-locked = true;
            spawn = ["swayosd-client" "--output-volume" "mute-toggle"];
          };
          "XF86MonBrightnessUp" = {
            _props.allow-when-locked = true;
            spawn = ["swayosd-client" "--brightness" "raise"];
          };
          "XF86MonBrightnessDown" = {
            _props.allow-when-locked = true;
            spawn = ["swayosd-client" "--brightness" "lower"];
          };
        };

        _children = [
          # 出力設定 (名前付き引数は _args)
          {
            output = {
              _args = ["eDP-1"];
              scale = 1.0;
            };
          }
          {
            output = {
              _args = ["DP-1"];
              _children = [
                {
                  position._props = {
                    x = 1920;
                    y = 0;
                  };
                }
                {scale = 1.0;}
              ];
            };
          }

          # 起動時に実行するアプリ
          {
            spawn-at-startup._args = ["fcitx5" "-d"];
          }

          # ウィンドウルール
          {prefer-no-csd = {};}
          {
            window-rule._children = [
              {
                match._props = {
                  app-id = "floorp";
                  title = "ピクチャーインピクチャー";
                };
              }
              {open-focused = false;}
              {open-floating = true;}
              {default-column-width.fixed = 480;}
              {default-window-height.fixed = 270;}
            ];
          }
          {
            window-rule._children = [
              {geometry-corner-radius = 12;}
              {clip-to-geometry = true;}
              {draw-border-with-background = false;}
            ];
          }
        ];
      };
    };
  };
}
