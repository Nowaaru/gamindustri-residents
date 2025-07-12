{withSystem, ...}:
withSystem "x86_64-linux" ({inputs', ...}: {
  home.packages = [
    inputs'.vintagestory.packages.vintagestory-wrapped
  ];
})
