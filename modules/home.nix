{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "home";

  nixos.always = {
    environment.systemPackages = [pkgs.home-manager];
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "home_manager_backup";
    };
  };
  home.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) username;
    in
    {
      home = {
        inherit username;
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
      };
    };
}
