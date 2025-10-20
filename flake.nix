{
  description = "Josh's nix flake";

  # Nix Configurations
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    experimental-features = [
      "cgroups"
      "flakes"
      "nix-command"
      "pipe-operators"
    ];

    trusted-users = [
      "root"
      "@admin"
      "@build"
      "@wheel"
    ];

    builders-use-substitutes = true;
    http-connections = 50;
    use-cgroups = true;
    lazy-trees = true;
    show-trace = true;
    warn-dirty = false;
  };

  # Flake Dependencies
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
  };

  # Flake Outputs for building systems
  outputs = inputs @ { nixpkgs, nix-darwin, ... }:
    let
      inherit (builtins) readDir;
      inherit (nixpkgs.lib) attrsToList const groupBy listToAttrs mapAttrs nameValuePair;

      lib' = nixpkgs.lib.extend (_: _: nix-darwin.lib);
      lib = lib'.extend <| import ./lib inputs;

      hostsByType =
        readDir ./hosts
        |> mapAttrs (name: const <| import ./hosts/${name} lib)
        |> attrsToList
        |> groupBy (item: "${item.value.class or "darwin"}Configurations")
        |> mapAttrs (const listToAttrs);

      hostConfigs =
        hostsByType.darwinConfigurations // hostsByType.nixosConfigurations
        |> attrsToList
        |> map (name: value: nameValuePair name value.config)
        |> listToAttrs;

    in hostsByType // hostConfigs;
}
