{ delib, ... }:
delib.module {
  name = "services.udisk2";

  nixos.always = {
  	services.udisks2.enable = true;
  	
  };
  home.always = {
  	services.udiskie.enable = true;
  };
}
