{ mulib, inputs, ... }:
mulib.module {
  name = "emacs";

  options.enable = mulib.bool.false;

  always.home = {
    imports = [ inputs.emacs-config.homeModules.default ];
  };

  home = {
    programs.emacs-twist = {
      enable = true;
      emacsclient.enable = true;
      serviceIntegration.enable = true;
    };
  };
}
