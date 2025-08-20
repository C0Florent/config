{ pkgs, lib, vscode-extensions, ... }:

{
  programs.vscode = {
    profiles.default.extensions =
    with vscode-extensions.vscode-marketplace;
    with pkgs.vscode-extensions; [
      oracle.sql-developer
      mongodb.mongodb-vscode

      mdk.vega-preview
      randomfractalsinc.vscode-vega-viewer
    ];

    profiles.default.userSettings = {
      "sqldeveloper.database.nls.territory" = "AUSTRALIA";
      "sqldeveloper.database.nls.ISOCurrency" = "AUSTRALIA";
      "sqldeveloper.format.general.keywordCase" = "UPPER";
      "sqldeveloper.format.indentation.identSpaces" = 4;
      "sqldeveloper.format.lineBreaks.maxCharLineWidth" = 80;

      "mdb.confirmRunAll" = false;
      "mdb.useDefaultTemplateForPlayground" = false;
    };
  };

  programs.git = {
    extraConfig.credential = {
      "https://git.infotech.monash.edu".helper = "!glab auth git-credential";
    };
  };
}
