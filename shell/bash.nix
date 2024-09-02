{
  programs.bash = {
    enable = true;

    shellAliases = {
      cfgview = "cfg $SHELL";
      cfgedit = "cfg \"sudo --preserve-env=SHLVL su\"";

      "²" = "true";
    };

    bashrcExtra = ''
      source ${builtins.toPath ./bash_functions.sh}
      unmute
    '';
  };
}
