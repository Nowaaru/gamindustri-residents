{master, ...}: {
  home.packages = with master; [
    clipse
  ];
}
