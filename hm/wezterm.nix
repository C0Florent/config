{ ... }:

{
  programs.wezterm = {
    enable = true;

    enableBashIntegration = true;

    extraConfig = ''
      return {
        color_scheme = 'Night Owl (Gogh)',
        font = wezterm.font('MartianMono Nerd Font'),
        font_size = 10.0,
        hide_tab_bar_if_only_one_tab = true,
      }
    '';
  };
}
