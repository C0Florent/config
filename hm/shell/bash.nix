{ lib, ... }:

{
  programs.bash = rec {
    enable = true;

    shellAliases = {
      cfgview = "cfg $SHELL";
      cfgedit = "cfg \"sudo --preserve-env=SHLVL su\"";

      hm = "home-manager";
      hms = "home-manager switch";

      "²" = "true";

      l = "ls -alh";

      ga = "git add";
      gc = "git commit";
      gcm = "git commit -m";
      gcam = "git commit -am";
      gp = "git push";
      gpl = "git pull";
      gcl = "git clone";
      gs = "git status";
      gr = "git restore";
      grs = "git restore --staged";
      gst = "git stash";
      gstp = "git stash pop";
      gl = "git log";
      gpf = "git push --force-with-lease";
      gpff = "git push --force";
      gd = "git diff";
      gb = "git branch";
      # gsw = "git switch"; I made gsw a script in gsw.nix
      gswc = "git switch -c";
      gm = "git merge";
      gf = "git fetch";
      grb = "git rebase";
      grbc = "git rebase --continue";

      ghcl = "ghcl -L 500";
      ghcle = "ghcl EpitechPromo2027";

      lg = "lazygit";

      prints = "printf -- '- %s\n'";

      epishell = ''docker run --rm -v "$(pwd):/usr/local/bugs/delivery" -it -w '/usr/local/bugs/delivery' -p 4242:4242 epitechcontent/epitest-docker'';
    };

    bashrcExtra = let
      foldOnAttributes = f: lib.attrsets.foldlAttrs (acc: name: _: f acc name);
      complete-alias-commands = foldOnAttributes (acc: aliasName: acc + ''
        complete -F _complete_alias ${aliasName}
      '') "" shellAliases;
    in ''
      source ${builtins.toPath ./bash_functions.sh}
      ${complete-alias-commands}
      unmute
    '';
  };
}
