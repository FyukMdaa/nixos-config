{ delib, config, lib, pkgs, ... }:
delib.module {
  name = "programs.zsh";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = { myconfig, ... }: let
    inherit (myconfig.constants) username;
  in {
    programs.zsh.enable = true;
    users.users.${username}.shell = pkgs.zsh;
  };

  home.ifEnabled = { myconfig, ... }: let
    inherit (myconfig.constants) username;
    homeConfig = if config ? home-manager
                 then config.home-manager.users.${username}
                 else config;
  in {
    programs.zsh = {
      enable = true;
      dotDir = "${homeConfig.xdg.configHome}/zsh";
      defaultKeymap = "emacs";
      enableCompletion = true;
      autosuggestion.enable = false;
      syntaxHighlighting.enable = false;
      autocd = true;

      history = {
        size = 10000;
        save = 10000;
        path = "${homeConfig.xdg.dataHome}/zsh/history";
        append = true;
        ignoreDups = true;
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        extended = true;
        share = true;
      };

      completionInit = ''
        autoload -Uz compinit
        setopt EXTENDEDGLOB
        local zcompdump="$XDG_CACHE_HOME/zsh/zcompdump" 
        if [[ -n $zcompdump(#qNmh-24) ]]; then
          compinit -C -d "$zcompdump"
        else
          compinit -d "$zcompdump"
          { rm -f "$zcompdump.zwc" && zcompile "$zcompdump" } &!
        fi
      '';

      antidote = {
        enable = true;
        plugins = lib.mkMerge [
          [
          	"zdharma-continuum/fast-syntax-highlighting"
          	"hlissner/zsh-autopair kind:defer"
          	"marlonrichert/zsh-autocomplete"
          	"chisui/zsh-nix-shell"
          ]
        ];
      };

      initContent = lib.mkMerge [ 
        ''
          unsetopt WARN_CREATE_GLOBAL
          setopt PRINT_EIGHT_BIT
          setopt MARK_DIRS
          setopt MAGIC_EQUAL_SUBST
          setopt complete_in_word

          zstyle ':completion:*' cache-path "''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

          # CORRECTを無効化
          unsetopt CORRECT

          # Shell Options
          setopt AUTO_CD
          setopt EXTENDED_GLOB
          setopt GLOB_DOTS
          setopt INC_APPEND_HISTORY
          setopt INTERACTIVE_COMMENTS
          setopt NO_BEEP
          setopt PROMPT_SUBST

          # 補完設定
          zstyle ':completion:*' menu select
          zstyle ':completion:*' rehash true
          zstyle ':completion:*' use-cache on
          zstyle ':completion:*' accept-exact '*(N)'
          zstyle ':completion:*' verbose yes
          zstyle ':completion:*:descriptions' format '%%B%%d%%b'
          zstyle ':completion:*:messages' format '%%d'
          zstyle ':completion:*:warnings' format 'No matches for: %%d'
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

          # zsh-autocompleteの設定
          zstyle ':autocomplete:*' min-input 2
          zstyle ':autocomplete:*' max-lines 10
          zstyle ':autocomplete:*' recent-dirs zoxide
          zstyle ':autocomplete:tab:*' widget-style menu-select
          zstyle ':autocomplete:*' list-lines 10

          # 自作関数
          function mkcd() {
            mkdir -p "$1" && cd "$1"
          }
        ''
      ];
    };

    home.activation.setupZshDirs = homeConfig.lib.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p "''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
      $DRY_RUN_CMD mkdir -p "''${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
    '';
  };

  myconfig.ifEnabled = {
  	programs.zeno.enable = true;

  	programs.zeno.snippets = [
  		{
  			name = "cd & ls";
  			keyword = "cdl";
  			snippet = "cd {{placeholder}} && ls";
  		}
  		{
  			name = "relode zsh";
  			keyword = "exzs";
  			snippet = "zeno-restart-server && exec zsh";
  		}
  	];
  };
}
