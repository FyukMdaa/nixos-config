{ mulib, ... }:
mulib.host {
  name = "Inspiron14-5445";
  os.security.tpm2.enable = true;
}
