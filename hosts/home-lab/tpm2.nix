{ mulib, ... }:
mulib.host {
  name = "home-lab";
  os.security.tpm2.enable = true;
}
