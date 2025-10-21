lib: lib.buildDarwinSystem (
  { lib, pkgs, ... }:
  let
    inherit (lib) collectNix remove;
  in {
    imports = collectNix ./. |> remove ./default.nix;

    nixpkgs.config.allowUnfree = true;

    networking.hostName = "josh";

    users.users.josh = {
      name = "josh";
      home = "/Users/josh";
      shell = pkgs.nushell;
    };

    home-manager.users.josh.home = {
      stateVersion = "25.05";
      homeDirectory = "/Users/josh";
    };

    system.stateVersion = 5;
  }
)
