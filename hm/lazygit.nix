{ pkgs, config, ... }:

{
  programs.lazygit = {

    enable = true;

    settings = {
      git.parseEmoji = true;
      git.overrideGpg = true;
      git.pagers = [{
        colorArg = "always";
        pager = "delta --dark --paging=never";
      }];
      gui.theme.selectedLineBgColor = [
        config.programs.alacritty.settings.colors.selection.background
      ];
    };

  };
}
