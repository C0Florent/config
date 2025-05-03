{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      add_newline = true;

      format = lib.concatStrings [
         ''[\[](cyan)''
         ''$shell''
         ''$shlvl''
         ''[/](bold white)''
         ''$username''
         ''[:](bold white)''
         ''$directory''
         ''([\(''

           ''$git_branch''
           ''$git_state''
         ''\)](blue))''
         ''[\]](cyan)''
         ''$line_break''
         ''$status''
         ''$character''
      ];

      shell = {
        disabled = false;
        format = "[$indicator]($style)";
        style = "bold green";
        bash_indicator = "bash";
        tcsh_indicator = "tcsh";
        fish_indicator = "fish";
        unknown_indicator = "??sh";
      };
      shlvl = {
        disabled = false;
        threshold = 1;
        format = ''[\($shlvl\)]($style)'';
        style = "green";
      };
      username = {
        show_always = true;
        style_user = "bold cyan";
        style_root = "bold purple";
        format = "[$user]($style)";
      };
      directory = {
        truncation_symbol = "…/";
        truncation_length = 2;
        style = "bold blue";
        read_only = "!";
        read_only_style = "red";
        format = "[$read_only]($read_only_style)[$path]($style)";
      };
      git_branch = {
        style = "blue";
        format = ''[$branch]($style)'';
      };
      git_state = {
        style = "blue";
        format = "[|$state($progress_current/$progress_total)]($style)";
      };
      status = {
        disabled = false;
        format = "[$status]($style)";
        style = "bold red";
      };
      character = rec {
        success_symbol = "[\\$](bright-yellow)";
        error_symbol = success_symbol;
      };
    };
  };
}
