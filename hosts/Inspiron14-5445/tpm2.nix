{ delib, ... }:
delib.host {
  name = "Inspiron14-5445";
  nixos.security.tpm2.enable = true;
}