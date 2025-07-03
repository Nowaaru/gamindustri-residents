{
  inputs,
  lib,
  pkgs,
  master,
  ...
}: {
  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.default
    master.floorp
    master.firefox

  ];
}
