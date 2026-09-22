{
  description = "Modular configuration of NixOS and Home Manager with mulix";

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
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mulix = {
      url = "github:fyukmdaa/mulix";
      inputs.nixpkgs.follows = "nixpkgs";
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

    umbriel.url = "github:noctalia-dev/umbriel";

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    floorp.url = "github:fyukmdaa/floorp-flake";

    fmpkgs.url = "github:fyukmdaa/fmnixpkgs";

    twist.url = "github:emacs-twist/twist.nix";

    emacs-config.url = "github:fyukmdaa/emacs-config";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    mulix,
    home-manager,
    ...
  }: let
    lib = nixpkgs.lib;
    m = mulix.lib {inherit lib inputs;};
    cfgs = m.configurations {
      paths = [./hosts ./modules ./overlays];
      conditionNames = import ./conditionNames.nix;
      configNames = import ./configNames.nix {inherit lib;};
      specialArgs = {inherit inputs;};
      homeManager = {
        enable = true;
        user = "fyukmdaa";
        useGlobalPkgs = true;
      };
      extraNixosModules = [
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.preservation
        inputs.lanzaboote.nixosModules.lanzaboote
      ];
    };
  in {
    inherit (cfgs) nixosConfigurations homeConfigurations;
  };
}
