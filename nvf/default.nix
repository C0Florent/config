{ pkgs, lib, ... }:

{
  vim = {
    autocomplete = {
      nvim-cmp.enable = true;
    };

    git = {
      enable = true;

      gitsigns.enable = true;
    };

    languages = {
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      nix.enable = true;
    };

    lsp = {
      enable = true;
    };
  };
}
