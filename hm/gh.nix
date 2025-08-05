{ pkgs, lib, ... }:

{
  programs.gh = {
    enable = true;

    gitCredentialHelper.enable = true;
  };
}
