{
  description = "Modular configuration of NixOS and Home Manager with Denix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    preservation.url = "github:nix-community/preservation";

    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix.url = "github:musnix/musnix";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango-ext = {
      # url = "github:ernestoCruz05/mango-ext";
      url = "github:FyukMdaa/mango-ext";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/v0.56.0";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-scroll-overview = {
      url = "github:yayuuu/hyprland-scroll-overview";
      inputs.hyprland.follows = "hyprland";
    };

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    floorp.url = "github:fyukmdaa/floorp-flake";

    fmpkgs.url = "github:fyukmdaa/fmnixpkgs";

    twist.url = "github:emacs-twist/twist.nix";

    emacs-config.url = "github:fyukmdaa/emacs-config";
  };

  outputs = {denix, ...} @ inputs: let
    mkConfigurations = moduleSystem:
      denix.lib.configurations {
        inherit moduleSystem;
        homeManagerUser = "fyukmdaa";

        paths = [
          ./hosts
          ./modules
          ./overlays
        ];

        extraModules =
          if moduleSystem == "nixos"
          then [
            inputs.disko.nixosModules.disko
            inputs.preservation.nixosModules.preservation
          ]
          else [];

        extensions = with denix.lib.extensions; [
          args
          overlays
          (base.withConfig {
            args.enable = true;
            hosts.features = {
              enable = true;
              # 利用したいロールをすべて定義
              features = [
                "gui"
                "cli"
                "mangowc"
                "hyprland"
                "niri"
                "draw"
                "dtm"
                "server"
                "video-edit"
                "android-dev"
                "token2"
              ];
              # 各名称に対して "{feature}Featured" というブール値が自動生成される
            };
          })
        ];

        specialArgs = {
          inherit inputs;
        };
      };
  in {
    nixosConfigurations = mkConfigurations "nixos";
    homeConfigurations = mkConfigurations "home";
  };
}
