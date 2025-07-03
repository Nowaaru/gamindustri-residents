{
  pkgs,
  master,
  stable,
  ...
}: {
  home.packages = with pkgs; [
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    (master.hydrus.overridePythonAttrs (finalAttrs:
      with lib; rec {
        pname = "hydrus";
        version = "627";
        src = fetchFromGitHub {
          owner = "hydrusnetwork";
          repo = "hydrus";
          tag = "v${version}";
          hash = "sha256-7zV+sQ22hrvCqMk7ePlAhSYG2495pEAyZYrep3NYoXE=";
        };
      }))
  ];
}
