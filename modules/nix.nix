{ delib, inputs, pkgs, ... }:
delib.module {
  name = "nix";

  home.always = {
    imports = [
      inputs.nix-index-database.homeModules.nix-index
    ];
  };

  nixos.always = {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];

    nixpkgs.overlays = [
      inputs.nix-index-database.overlays.nix-index
    ];

    programs = {
      nix-index-database.comma.enable = true;
    };
    
    environment.systemPackages = with pkgs; [
    	cachix
    	nh
    	sops
    	nix-prefetch-git
    	nix-inspect
    	nurl
    	nix-health
    	nix-index
    	nvd
    	statix
    	deadnix
    	devenv
    	lix.nix-init
    	lix.nix-direnv
    	lix.nix-update
    	lix.nix-eval-jobs
    ];

    nixpkgs.config.allowUnfree = true;
    
    nix = {
      package = pkgs.lixPackageSets.stable.lix;

      settings = {
        experimental-features = ["nix-command" "flakes" "cgroups"];
        ssl-cert-file = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
        auto-optimise-store = true;
        max-jobs = "auto";
        cores = 0;
        trusted-users = ["root" "@wheel"];
        builders-use-substitutes = true;
        use-cgroups = true;
        use-xdg-base-directories = true;

	    substituters = [
	      "https://cache.nixos.org"
	      "https://nix-community.cachix.org"
	      "https://attic.xuyh0120.win/lantian"
          "https://hyprland.cachix.org"
	    ];
	    trusted-public-keys = [
	      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
	      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
	      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
	    ];
      };

      # extraOptions = ''
      #   !include ${config.sops.secrets.github_token.path}
      # '';

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      optimise = {
        automatic = true;
        dates = ["weekly"];
      };
    };
  };
}
