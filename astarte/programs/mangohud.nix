{
  pkgs,
  configure,
  ...
}: {
  programs.mangohud = {
    enable = true;
    settings = configure "mangohud";
  };
}
