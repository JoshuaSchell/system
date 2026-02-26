{ config, lib, ... }:
let
  inherit (lib) last mkConst splitString;
in {
  options = {
    os = mkConst <| last splitString "-" config.nixpkgs.hostPlatform.system;
    isLinux  = mkConst <| config.os == "linux";
    isDarwin = mkConst <| config.os == "darwin";
    isServer = mkConst <| config.type == "server";
    isPersonal = mkConst <| config.type == "personal";
  };
}
