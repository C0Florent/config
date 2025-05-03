{ pkgs, vscode-extensions, ... }:

let
  extensions = vscode-extensions;
in
{
  programs.vscode = {
    package = pkgs.vscodium;
    enable = true;
    mutableExtensionsDir = false;

    profiles.default.extensions =
    with extensions.vscode-marketplace;
    with pkgs.vscode-extensions; [
      vscode-icons-team.vscode-icons
      eamodio.gitlens
      shardulm94.trailing-spaces

      github.vscode-github-actions

      bbenoist.nix
      brettm12345.nixfmt-vscode

      llvm-vs-code-extensions.vscode-clangd
      twxs.cmake
      xaver.clang-format

      dart-code.dart-code
      dart-code.flutter

      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      vadimcn.vscode-lldb

      extensions.vscode-marketplace.sdras.night-owl

      tomoki1207.pdf
      streetsidesoftware.code-spell-checker

      justusadam.language-haskell
      haskell.haskell

      iliazeus.vscode-ansi

      ms-vscode.live-server

      vscodevim.vim
      usernamehw.errorlens
    ];

    profiles.default.keybindings = [
      {
        key = "ctrl+[Backquote]";
        command = "terminal.focus";
        when = null;
      }
      {
        key = "ctrl+[Quote]";
        command = "workbench.action.navigateBack";
        when = "canNavigateBack";
      }
      {
        key = "ctrl+alt+M";
        command = "workbench.action.terminal.sendSequence";
        args.text = "make\n";
      }
      {
        key = "alt+v";
        when = ''inputFocus && (
          vim.mode == 'Disabled' || vim.mode == 'Normal'
        )'';
        command = "runCommands";
        args = {
          commands = [
            "toggleVim"
            #"settings.cycle.vimSmartLineNumbers"
            #"settings.cycle.lineNumber"
          ];
        };
      }
      {
        key = "ctrl+s";
        command = "vim.remap";
        when = "inputFocus && vim.mode == 'Insert'";
        args = {
          after = [ "<C-s>" ];
        };
      }
    ];

    profiles.default.userSettings = {
      "git.openRepositoryInParentFolders" = "always";
      "window.menuBarVisibility" = "toggle";
      "window.titleBarStyle" = "custom";

      "terminal.integrated.fontFamily" = "MartianMono Nerd Font";
      "terminal.integrated.fontSize" = 12;
      "terminal.integrated.tabs.focusMode" = "singleClick";
      "files.insertFinalNewline" = true;

      "terminal.integrated.shellIntegration.enabled" = false;

      "workbench.colorTheme" = "Night Owl (No Italics)";
      "workbench.iconTheme" = "vscode-icons";
      "workbench.colorCustomizations" = let
        # Provided by https://github.com/sdras/night-owl-vscode-theme?tab=readme-ov-file#separate-the-editor-from-the-sidebar,
        # patched to preference
        activateSideBar = builtins.fromJSON ''
          {
            "activityBar.border": "#102a44",
            "editorGroup.border": "#102a44",
            "sideBar.border": "#102a44"
          }
        ''; in {
          "[Night Owl]" = activateSideBar;
          "[Night Owl (No Italics)]" = activateSideBar;
      };

      "[dart]" = {
        "editor.formatOnSave" = true;
        "editor.formatOnType" = false;

        "editor.rulers" = [ 80 ];
        "editor.selectionHighlight" = false;
        "editor.tabCompletion" = "onlySnippets";
        "editor.wordBasedSuggestions" = "off";
      };
      "editor.hover.delay" = 500;
      "editor.minimap.renderCharacters" = false;
      "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
      "[makefile]"."editor.tabSize" = 8;
      "editor.inlayHints.fontSize" = 12;
      "cSpell.userWords" = [ "Epitech" ];

      "haskell.manageHLS" = "PATH";
      "haskell.serverExecutablePath" = "haskell-language-server-wrapper";

      "terminal.integrated.env.linux" = { SHLVL = 1; BAR = "foo"; };
      "terminal.integrated.profiles.linux" = {
        "bash" = {
          "path" = "~/.bashrc";
          "icon" = "terminal-bash";
          "env" = {
            SHLVL = 1;
            PREV_SHLVL = "$SHLVL";
            "FOO" = "bar";
          };
        };
      };

      "chat.commandCenter.enabled" = false;
      "workbench.editor.showTabs" = "single";

      "vim.smartRelativeLine" = true;
      "vim.normalModeKeyBindings" = [
        {
          before = ["<C-p>"];
          commands = [
            "workbench.action.quickOpen"
          ];
        }
        {
          before = ["<C-space>"];
          commands = [
            "editor.action.triggerSuggest"
          ];
          when = "editorHasCompletionItemProvider && textInputFocus && !editorReadonly && !suggestWidgetVisible";
        }
        {
          before = ["<C-l>"];
          commands = [ "workbench.action.increaseViewSize" ];
        }
        {
          before = ["<C-h>"];
          commands = [ "workbench.action.decreaseViewSize" ];
        }
      ];
      "vim.insertModeKeyBindings" = [
        {
          before = [ "<C-s>" ];
          after = [ "<Esc>" ":" "w" "<CR>" ];
        }
      ];
    };
  };
}
