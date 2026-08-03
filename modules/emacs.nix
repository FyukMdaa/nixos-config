{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "programs.emacs";
  options = delib.singleEnableOption false;
  home.always = {
    imports = [ inputs.emacs-config.homeModules.default ];
  };
  home.ifEnabled = {
     programs.emacs-twist = {
     	enable = true;
     	emacsclient.enable = true;
     	serviceIntegration.enable = true;
     };
  };
}
