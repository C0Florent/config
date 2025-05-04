inputs@{ pkgs, lib, mylib, mypkgs, ... }:

{
  home.packages = mylib.attrsToListRec mypkgs;
}
