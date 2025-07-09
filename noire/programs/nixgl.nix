{
  configure,
  inputs,
  pkgs,
  lib,
  ...
}: let
  nix-gl = import inputs.nixgl {
    inherit pkgs;
    nvidiaVersion = "575.64";
    nvidiaHash = "sha256-6wG8/nOwbH0ktgg8J+ZBT2l5VC8G5lYBQhtkzMCtaLE=";
  };
in {
  home.packages = with (lib.traceVal nix-gl); [
    nixVulkanNvidia
  ];

  nixGL = configure "nixgl";
}
