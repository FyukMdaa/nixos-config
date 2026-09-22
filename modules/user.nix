{ mulib, host, ... }:
mulib.module {
  name = "user";

  options.enable = mulib.bool.true;

  always.os = { myconfig, ... }: let
    inherit (myconfig.constants) username;
  in {
    users = {
      groups.${username} = { };

      users.${username} = {
        isNormalUser = true;
        home = "/home/${username}";
        extraGroups = [ "wheel" ];
      };
    };
  };
}
