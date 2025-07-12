{master, ...}: {
  home.packages = with master; [
    btop
  ];
}
