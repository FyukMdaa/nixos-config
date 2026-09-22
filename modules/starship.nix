{
  mulib,
  host,
  lib,
  ...
}:
mulib.module {
  name = "starship";

  options.enable = [host.feat.cli];

  home = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        format = lib.concatStringsSep "" [
          "[](#C77DFF)"
          "$os"
          "$username"
          "[](bg:#FF9AA2 fg:#C77DFF)"
          "$directory"
          "[](fg:#FF9AA2 bg:#FFB74D)"
          "$git_branch"
          "$git_status"
          "[](fg:#FFB74D bg:#90CAF9)"
          "$c"
          "$elixir"
          "$elm"
          "$golang"
          "$gradle"
          "$haskell"
          "$java"
          "$julia"
          "$nodejs"
          "$nim"
          "$rust"
          "$scala"
          "[](fg:#90CAF9)"
          "$fill"
          "[](#80DEEA)"
          "$cmd_duration"
          "[](bg:#82B1FF fg:#80DEEA)"
          "$time"
          "[](fg:#82B1FF)"
          "\n"
          "$character"
        ];

        fill.symbol = " ";

        username = {
          show_always = true;
          style_user = "bg:#C77DFF fg:black";
          style_root = "bg:#C77DFF fg:black";
          format = "[$user ]($style)";
          disabled = false;
        };

        os = {
          style = "bg:#C77DFF fg:black";
          disabled = true;
        };

        directory = {
          style = "bg:#FF9AA2 fg:black";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
        };

        # --- 言語系（共通スタイル）---
        c = {
          symbol = " ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        cpp = {
          symbol = " ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        elixir = {
          symbol = " ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        elm = {
          symbol = " ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        golang = {
          symbol = " ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        gradle = {
          symbol = " ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        haskell = {
          symbol = " ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        java = {
          symbol = " ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        julia = {
          symbol = " ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        nodejs = {
          symbol = "";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        nim = {
          symbol = "󰆥 ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        rust = {
          symbol = "";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };
        scala = {
          symbol = " ";
          style = "bg:#90CAF9 fg:black";
          format = "[ $symbol ($version) ]($style)";
        };

        # --- git ---
        git_branch = {
          symbol = "";
          style = "bg:#FFB74D fg:black";
          format = "[ $symbol $branch ]($style)";
        };
        git_status = {
          style = "bg:#FFB74D fg:black";
          format = "[$all_status$ahead_behind ]($style)";
        };

        # --- cmd_duration ---
        cmd_duration = {
          disabled = false;
          min_time = 1000;
          format = "[ 󰔛 $duration ]($style)";
          style = "bg:#80DEEA fg:black";
        };

        # --- time ---
        time = {
          disabled = false;
          time_format = "%H:%M:%S";
          style = "bg:#82B1FF fg:black";
          format = "[ 󰥔 $time ]($style)";
        };

        # --- character ---
        character = {
          success_symbol = "[❯](bold #90CAF9) ";
          error_symbol = "[❯](bold #FF6B6B) ";
          vicmd_symbol = "[❮](bold #90CAF9) ";
        };
      };
    };
  };
}
