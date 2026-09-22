{ mulib, ... }:
mulib.module {
  name = "nix-ld";

  options.enable = mulib.bool.false;

  os = {
    programs.nix-ld.enable = true;
  };
}
