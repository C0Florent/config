{
  programs.alacritty.enable = true;

  programs.alacritty.settings = {
    general.live_config_reload = false;

    bell = {
      animation = "EaseOutQuart";
      duration = 10;
      color = "#444444";
    };

    colors = {
      draw_bold_text_with_bright_colors = true;
      primary = {
        background = "#011627";
        foreground = "#c6cedb";
      };
      normal = {
        black = "#011627";
        red = "#EF5350";
        green = "#22da6e";
        yellow = "#c5e478";
        blue = "#82AAFF";
        magenta = "#C792EA";
        cyan = "#21c7a8";
        white = "#ffffff";
      };
      bright = {
        black = "#575656";
        red = "#EF5350";
        green = "#22da6e";
        yellow = "#ffeb95";
        blue = "#82AAFF";
        magenta = "#C792EA";
        cyan = "#7fdbca";
        white = "#ffffff";
      };
      cursor = {
        text = "CellBackground";
        cursor = "CellForeground";
      };
      vi_mode_cursor = {
        text = "CellBackground";
        cursor = "#22da6e";
      };
      search = {
        matches = {
          foreground = "#000000";
          background = "#22da6e";
        };
        focused_match = {
          foreground = "#ffffff";
          background = "#22da6e";
        };
      };
      footer_bar = {
        foreground = "#ffffff";
        background = "#1d3b53";
      };
      selection = {
        text = "#ffffff";
        background = "#0d486e";
      };
    };

    cursor = {
      style = "Block";
      unfocused_hollow = true;
    };

    debug = {
      render_timer = false;
    };

    font = {
      size = 10;
      normal = {
        family = "MartianMono Nerd Font";
      };
    };

    mouse = {
      bindings = [
        {
          action = "PasteSelection";
          mouse = "Middle";
        }
      ];
    };

    keyboard = {
      bindings = [
        {
          key = "Back";
          mods = "Control";
          chars = builtins.fromJSON ''"\u0017"'';
        }
      ];
    };

    scrolling = {
      history = 15000;
      multiplier = 3;
    };

    selection = {
      save_to_clipboard = false;
      semantic_escape_chars = ",│`|:\"' ()[]{}<>";
    };

    window = {
      decorations = "Full";
      dynamic_title = true;
      opacity = 0.95;
      startup_mode = "Windowed";
      resize_increments = true;
      dimensions = {
        columns = 80;
        lines = 30;
      };
      padding = {
        x = 0;
        y = 0;
      };
    };
  };
}
