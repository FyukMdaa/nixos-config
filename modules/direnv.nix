{ mulib, host, pkgs, ... }:
mulib.module {
  name = "direnv";

  options.enable = [ host.feat.cli ];

  os.environment.systemPackages = [ pkgs.git ];

  home = {
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
