{
  delib,
  inputs,
  pkgs,
  lib,
  ...
}: let
  lua = lib.generators.mkLuaInline;
  bind = key: dispatcher: {
    _args = [
      key
      (lua dispatcher)
    ];
  };
  on = event: body: {
    _args = [
      event
      (lua ''function() ${body} end'')
    ];
  };
  bezier = name: x0: y0: x1: y1: {
    _args = [
      name
      {
        type = "bezier";
        points = [
          [x0 y0]
          [x1 y1]
        ];
      }
    ];
  };
  spring = name: mass: stiffness: dampening: {
    _args = [
      name
      {
        type = "spring";
        mass = mass;
        stiffness = stiffness;
        dampening = dampening;
      }
    ];
  };
  execonece = cmd: ''hl.exec_cmd("${cmd}")'';
  exec = cmd: ''hl.dsp.exec_cmd("${cmd}")'';
  kill = ''hl.dsp.window.close()'';
  exit = ''hl.dsp.exit()'';
  maxi = ''
    function()
      hl.dispatch(hl.dsp.layout("colresize +conf"))
    end
  '';
  focus = dir: ''hl.dsp.focus({direction = "${dir}"})'';
  moveWindow = dir: ''hl.dsp.window.move({direction = "${dir}"})'';
  toWorkspace = dir: ''hl.dsp.focus({workspace = "${dir}"})'';
  moveToWorkspace = dir: ''hl.dsp.window.move({workspace = "${dir}"})'';
  plugin = name: fn: arg: ''
    function()
      if hl.plugin.${name} ~= nil then
        hl.plugin.${name}.${fn}("${arg}")
      end
    end
  '';
in
  delib.module {
    name = "programs.hyprland";
    options = delib.moduleOptions ({myconfig, ...}: {
      enable = delib.boolOption myconfig.host.hyprlandFeatured;
    });

    nixos.always.imports = [inputs.hyprland.nixosModules.default];
    home.always.imports = [inputs.hyprland.homeManagerModules.default];

    nixos.ifEnabled = {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = false;
      };
    };

    home.ifEnabled = {
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        plugins = ["${inputs.hyprland-scroll-overview.packages.${pkgs.stdenv.hostPlatform.system}.default}/lib/libscrolloverview.so"];

        settings = {
          on = [
            (
              on "hyprland.start" ''
                ${execonece "fcitx5 -d &"}
              ''
            )
          ];
          config = {
            plugin = {
              scrolloverview = {
                gesture_distance = 300;
                scale = 0.5;
                workspace_gap = 100;
                layout = "vertical";
                wallpaper = 0;
                blur = true;

                shadow = {
                  enabled = false;
                  range = 50;
                  render_power = 3;
                  color = "0xee1a1a1a";
                };
              };
            };
            general = {
              gaps_in = 4;
              gaps_out = 4;
              border_size = 3;
              resize_on_border = true;
              layout = "scrolling";
              "col.active_border" = "rgba(888888ff)";
              "col.inactive_border" = "rgba(333333ff)";
            };
            decoration = {
              rounding = 10;
            };
            input = {
              kb_layout = "jp";
              follow_mouse = 0;
              touchpad = {
                natural_scroll = true;
              };
            };
            binds = {
              window_direction_monitor_fallback = false;
            };
            scrolling = {
              fullscreen_on_one_column = false;
              column_width = 0.5;
              focus_fit_method = 1;
              follow_focus = true;
              follow_min_visible = 0.4;
              explicit_column_widths = "0.5, 1.0";
              wrap_focus = false;
              wrap_swapcol = false;
              direction = "right";
            };
          };

          monitor = [
            {
              output = "eDP-1";
              mode = "preferred";
              position = "auto";
              scale = 1;
            }
            {
              output = "";
              mode = "preferred";
              position = "auto";
              scale = 1;
            }
          ];

          curve = [
            (bezier "md3_decel" 0.05 0.7 0.1 1)
            (bezier "md3_accel" 0.3 0 0.8 0.15)
            (bezier "menu_decel" 0.1 1 0 1)
            (bezier "menu_accel" 0.38 0.04 1 0.07)
            (spring "spring_menu" 1 80 14)
            (spring "spring_window" 1 90 20)
            (spring "spring_open" 1 90 20)
            (spring "spring_workspace" 1 90 20)
            (spring "spring_special" 1 90 20)
          ];
          animation = [
            {
              leaf = "windows";
              enabled = true;
              speed = 2;
              spring = "spring_window";
            }
            {
              leaf = "windowsIn";
              enabled = true;
              speed = 2;
              spring = "spring_window";
            }
            {
              leaf = "windowsOut";
              enabled = true;
              speed = 2.5;
              spring = "spring_window";
            }
            {
              leaf = "border";
              enabled = false;
            }
            {
              leaf = "borderangle";
              enabled = false;
            }
            {
              leaf = "fade";
              enabled = false;
            }
            {
              leaf = "zoomFactor";
              enabled = true;
              speed = 6;
              bezier = "md3_decel";
            }
            {
              leaf = "layersIn";
              enabled = true;
              speed = 4;
              spring = "spring_menu";
              style = "slidefade";
            }
            {
              leaf = "layersOut";
              enabled = true;
              speed = 3;
              bezier = "menu_accel";
              style = "slidefade";
            }
            {
              leaf = "fadeLayersIn";
              enabled = true;
              speed = 3;
              bezier = "menu_decel";
            }
            {
              leaf = "fadeLayersOut";
              enabled = true;
              speed = 2.5;
              bezier = "menu_accel";
            }
            {
              leaf = "workspaces";
              enabled = true;
              speed = 4;
              spring = "spring_workspace";
              style = "slidevert";
            }
            {
              leaf = "specialWorkspace";
              enabled = true;
              speed = 2;
              spring = "spring_special";
              style = "slidefade 20%";
            }
          ];

          bind = [
            (bind "SUPER + O" (plugin "scrolloverview" "overview" "toggle all"))
            (bind "SUPER + D" (exec "wofi --show drun"))
            (bind "SUPER + RETURN" (exec "ghostty"))
            (bind "SUPER + SHIFT + E" exit)
            (bind "SUPER + M" maxi)
            (bind "SUPER + Q" kill)
            (bind "SUPER + H" (focus "left"))
            (bind "SUPER + L" (focus "right"))
            (bind "SUPER + K" (toWorkspace "-1"))
            (bind "SUPER + J" (toWorkspace "+1"))
            (bind "SUPER + 1" (toWorkspace "1"))
            (bind "SUPER + 2" (toWorkspace "2"))
            (bind "SUPER + 3" (toWorkspace "3"))
            (bind "SUPER + 4" (toWorkspace "4"))
            (bind "SUPER + 5" (toWorkspace "5"))
            (bind "SUPER + 6" (toWorkspace "6"))
            (bind "SUPER + 7" (toWorkspace "7"))
            (bind "SUPER + 8" (toWorkspace "8"))
            (bind "SUPER + 9" (toWorkspace "9"))
            (bind "SUPER + SHIFT + H" (moveWindow "left"))
            (bind "SUPER + SHIFT + L" (moveWindow "right"))
            (bind "SUPER + SHIFT + K" (moveToWorkspace "-1"))
            (bind "SUPER + SHIFT + J" (moveToWorkspace "+1"))
            (bind "SUPER + SHIFT + 1" (moveToWorkspace "1"))
            (bind "SUPER + SHIFT + 2" (moveToWorkspace "2"))
            (bind "SUPER + SHIFT + 3" (moveToWorkspace "3"))
            (bind "SUPER + SHIFT + 4" (moveToWorkspace "4"))
            (bind "SUPER + SHIFT + 5" (moveToWorkspace "5"))
            (bind "SUPER + SHIFT + 6" (moveToWorkspace "6"))
            (bind "SUPER + SHIFT + 7" (moveToWorkspace "7"))
            (bind "SUPER + SHIFT + 8" (moveToWorkspace "8"))
            (bind "SUPER + SHIFT + 9" (moveToWorkspace "9"))
          ];
        };
      };
    };
  }
