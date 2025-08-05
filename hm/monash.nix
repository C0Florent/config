{ pkgs, lib, ... }:

{
  programs.git = {
    extraConfig.credential = {
      "https://git.infotech.monash.edu".helper = "!glab auth git-credential";
    };
  };
}
