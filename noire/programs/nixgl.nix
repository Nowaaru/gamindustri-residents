{
  configure,
  inputs,
  ...
}: {
  home.packages = with inputs.nixgl.packages.x86_64-linux; [
    nixGLDefault
    nixVulkanNvidia
  ];

  nixGL = configure "nixgl";
}
