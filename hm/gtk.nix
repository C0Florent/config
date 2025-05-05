{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      package = pkgs.nordic;
      name = "Nordic-darker-standard-buttons";
    };
  };
}
