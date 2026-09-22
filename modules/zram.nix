{ mulib, ... }:
mulib.module {
  name = "zram";

  options = {
    enable = mulib.bool.true;
    zramPercent = mulib.int 25;
  };

  os = { opt, ... }: {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = opt.zramPercent;
      priority = 999;
    };
  };
}
