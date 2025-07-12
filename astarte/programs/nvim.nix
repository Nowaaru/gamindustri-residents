{ pkgs, lib, configure, inputs, config, ... }:
{
  imports = [inputs.nvf.homeManagerModules.default];

  home.packages = with pkgs; lib.lists.singleton imagemagick; 

  programs.nvf = {
    enable = true;
    settings.vim = configure "nvf" config;
  };
}
