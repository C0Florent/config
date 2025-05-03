{ pkgs, lib, inputs, ... }:

{
  nix.registry = {
    nixpkgs = rec {
      flake = inputs.nixpkgs-stable;

      # This below "to" is what the NixOS module would produce from
      # the above "flake" attribute.
      # Problem is: registries defined with a `flake` attribute using the
      # NixOS nix-flakes module get their `to` defined with `mkDefault`
      # and `nix.registry.nixpkgs.to` is already `mkDefault`ed somewhere else
      to = {
        type = "path";
        path = flake.outPath;
      }
      // lib.filterAttrs (n: _: n == "lastModified" || n == "rev" || n == "narHash") flake;
    };
    nixpkgs-unstable.flake = inputs.nixpkgs;
  };
}
