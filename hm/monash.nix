{ pkgs, lib, vscode-extensions, ... }:

{
  programs.vscode = {
    profiles.default.extensions =
    with vscode-extensions.vscode-marketplace;
    with pkgs.vscode-extensions; [
      oracle.sql-developer
      mongodb.mongodb-vscode
    ];
  };

  programs.git = {
    extraConfig.credential = {
      "https://git.infotech.monash.edu".helper = "!glab auth git-credential";
    };
  };
}
