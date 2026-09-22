{ mulib, pkgs, ... }:
mulib.module {
  name = "home";

  options.enable = mulib.bool.true;

  always.os = {
    environment.systemPackages = [ pkgs.home-manager ];
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "home_manager_backup";
    };
  };

  always.home = { myconfig, ... }: let
    inherit (myconfig.constants) username;
  in {
    home = {
      inherit username;
      homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
    };
  };
}
