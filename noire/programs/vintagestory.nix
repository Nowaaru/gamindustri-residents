{
  inputs,
  lib,
  withSystem,
  ...
}:
withSystem "x86_64-linux" (ctx @ {
  config,
  inputs',
  ...
}: {
  home.packages = [
    (lib.traceVal inputs').vintagestory.packages.vintagestory-wrapped
  ];
})
