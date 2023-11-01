{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }@inputs:
    let
      system = "x86_64-linux";
      specialArgs = { inherit inputs; inherit hyprland; inherit system; }; # https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; inherit hyprland; inherit system; }; # https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                users.jenss = ./home-manager/home.nix;
                extraSpecialArgs = specialArgs;
              };
            }
          ];
        };
      };
    };
}
