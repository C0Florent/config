{ pkgs, lib, ppause ? pkgs.callPackage ./ppause.nix { inherit pkgs; }, ... }:

(pkgs.writers.writeNuBin "hyprppause" ./hyprppause.nu)
  .overrideAttrs (finalAttrs: previousAttrs: {
    buildCommand = previousAttrs.buildCommand + ''
      ln -s ${lib.escapeShellArg (lib.getExe ppause)} "$out/bin/ppause.nu"
      touch "$out/bin/newfile"
    '';
  })
