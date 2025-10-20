{ pkgs, ... }: {
  home-manager.sharedModules = [{
    programs.direnv = {
      enabled = true;
      package = pkgs.direnv;
      silent = false;
      enableNushellIntegration = true;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };
  }];
}
