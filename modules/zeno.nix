{ mulib, pkgs, lib, ... }:
mulib.module {
  name = "zeno";

  # denix では default false で zsh から myconfig.ifEnabled で有効化していたが、
  # zsh は常に有効なので zeno も default true にする。
  options = {
    enable = mulib.bool.true;

    snippets = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
      description = "List of zeno snippets added from various modules.";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Extra global settings for zeno.";
    };
  };

  home = { opt, zenoSnippets, ... }: {
    home.packages = with pkgs; [
      stable.deno
      fzf
    ];

    programs.zsh = {
      antidote = {
        enable = true;
        plugins = [ "yuki-yano/zeno.zsh" ];
      };

      initContent = ''
        export ZENO_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}/zeno"

        if [[ -n $ZENO_LOADED ]]; then
            bindkey " " zeno-auto-snippet
            bindkey '^m' zeno-auto-snippet-and-accept-line
            bindkey '^i' zeno-completion
            bindkey '^x^p' zeno-insert-snippet

            bindkey '^x ' zeno-insert-space
            bindkey '^x^m' accept-line

            bindkey '^r' zeno-history-selection
            bindkey '^x^f' zeno-ghq-cd
        fi
      '';
    };

    # zenoSnippets configName で他モジュールから送られたスニペットを集約
    xdg.configFile."zeno/config.yml".text = builtins.toJSON (
      opt.settings // { snippets = zenoSnippets; }
    );
  };
}
