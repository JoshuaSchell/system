{
  system.defaults.dock = {
    autohide = true;
    show-recents = false;
    mru-spaces = false;
    mouse-over-hilite-stack = true;
    enable-spring-load-actions-on-all-items = true;
    expose-animation-duration = 0.1;
    tilesize = 48;

    persistent-apps = [
      "/Applications/Ghostty.app"
      "/Applications/Zen.app"
      "/Applications/Zed.app"
      "/System/Applications/Mail.app"
      "/Applications/Vesktop.app"
    ];
  };

  system.defaults.CustomSystemPreferences."com.apple.dock" = {
    wvous-tl-corner = 0;
    wvous-tr-corner = 2;
    wvous-bl-corner = 3;
    wvous-br-corner = 4;
  };
}
