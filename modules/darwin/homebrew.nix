{
  homebrew = {
    enable = true;
    brews = [ ];
    taps = [ ];
    casks = [
      "cursor"
      "docker-desktop"
      "font-jetbrains-mono"
      "ghostty"
      "helium-browser"
      "raycast"
      "rider"
      "vesktop"
      "visual-studio-code"
      "wezterm"
      "zed"
      "zen"
      "zoom"
      "zotero"
    ];
    masApps = { };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
