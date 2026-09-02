{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.direnv";

  options = delib.moduleOptions ({myconfig, ...}: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  nixos.ifEnabled.environment.systemPackages = [pkgs.git];

  home.ifEnabled = {
    programs.direnv = {
      enable = true;
      package = pkgs.direnv;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
        package = pkgs.lix.nix-direnv;
      };
    };
  };
}
