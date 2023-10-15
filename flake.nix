{
  description = "Home Manager configuration of rafadc";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."rafadc" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
	  ./home.nix

	  ./git.nix
	  
	  ({ ... }: {
	    nixpkgs.config = {
	      allowUnfree = true;
	      allowUnfreePredicate = _: true; # Needed due to a longstanding bug in Nix
	    };
	  })
	];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix

      };
    };
}
