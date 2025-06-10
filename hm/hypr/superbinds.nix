{ pkgs, lib, mycfg, ... }:

{
  mycfg.hypr.superbinds = {
    mod = "$mainMod";
  };
}
