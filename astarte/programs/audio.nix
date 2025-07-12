{master, ...}: {
  home.packages = with master; [
    ncpamixer
  ];
}
