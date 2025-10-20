inputs: self: super:
let
  inherit (self) attrValues filter getAttrFromPath hasAttrByPath collectNix;

  collectInputs =
  let
    inputsList = attrValues inputs;
  in path: inputsList
    |> filter (hasAttrByPath path)
    |> map (getAttrFromPath path);

  linuxInputs   = collectInputs [ "nixosModules" "default" ];
  darwinInputs  = collectInputs [ "darwinModules" "default" ];
  overlayInputs = collectInputs [ "overlays" "default" ];

  customOverlays = import ./overlays.nix inputs;
  overlayModule = { nixpkgs.overlays = overlayInputs ++ customOverlays; };

  commonModules = collectNix ../modules/common;
  linuxModules  = collectNix ../modules/linux;
  darwinModules = collectNix ../modules/darwin;

  specialArgs = inputs // { inherit inputs; lib = self; };

in {
  buildNixosSystem = module: super.nixosSystem {
    inherit specialArgs;
    modules = [ module overlayModule ] ++ commonModules ++ linuxModules ++ linuxInputs;
  };

  buildDarwinSystem = module: super.darwinSystem {
    inherit specialArgs;
    modules = [ module overlayModule ] ++ commonModules ++ darwinModules ++ darwinInputs;
  };
}
