{
  mulib,
  pkgs,
  lib,
  zeno,
  ...
}:
mulib.module {
  name = "zeno";

  options = {
    enable = [(zeno.enable == true)];

    snippets = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [];
      description = "List of zeno snippets added from various modules.";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Extra global settings for zeno.";
    };
  };

  home = {
    opt,
    zenoSnippets,
    ...
  }: {
    home.packages = with pkgs; [
      stable.deno
      fzf
    ];

    programs.zsh = {
      antidote = {
        enable = true;
        plugins = ["yuki-yano/zeno.zsh"];
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
      opt.settings // {snippets = zenoSnippets;}
    );
  };
}
