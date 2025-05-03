{ pkgs, ... }:

{
  programs.bat = {

    enable = true;

    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];

    config = {
      theme = "night-owl";
    };

    themes = {
      night-owl = {
        src = pkgs.fetchFromGitHub {
          owner = "batpigandme";
          repo = "night-owlish";
          rev = "a196e5528574e48ca4cdcbe0a0db59031a0b9be6";
          sha256 = "sha256-kjW5U4Om5SK0UzFNVRlc7As+hgwDL5b3Ohg0dUDd9OY=";
        };
        file = "tmTheme/night-owlish.tmTheme";
      };
    };

  };
}
