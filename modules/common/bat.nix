{
  programs.bat = {
    enable = true;
    themes = {
      gruvbox-dark = builtins.readFile ./gruvbox-dark.theme;
    };
  };
}