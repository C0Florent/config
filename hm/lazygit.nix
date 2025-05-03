{ pkgs, ... }:

{
  programs.lazygit = {

    enable = true;

    settings = {
      git.parseEmoji = true;
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
    };

  };
}
