# ***config***

This repo simply named "config" holds every bit of personal software configuration I wrote overtime.

## Quick tour around

As the repo stats show, this config is very nix-oriented. If you have no idea what Nix is, go [check it out](https://nixos.org), it's great.  
This repo contains a nix flake which declares my single-host NixOS config as well as my single-user standalone [home-manger](https://github.com/nix-community/home-manager/). I'll certainly get around to multi-host/multi-user one day, but I already have enough work to do for now, and no real use case in the near future.

Other non-Nix-specific things include:

- [Hyprland](https://hyprland.org) config (which is written in nix, still)
- Some small shell scripts in ./packages/scripts
- `portabashrc`, a minimalist, portable, independant bashrc which I always keep at hand when I'm travelling to remote servers or containers, where my full config is not available, just to not get homesick too quickly.

## Installing

To install the NixOS config, you can either clone or symlink this repo to /etc/nixos and run `nixos-rebuild switch`, or clone it anywhere and run `nixos-rebuild switch --flake <path/to/the/flake>`. NixOS doesn't actually care at all where the config is stored, it just needs to know where it is to evaluate it in order to build the system, and then forgets about it. I bet you could even `nixos-rebuild switch --flake github:C0Florent/config`

To install the home-manager config, everything goes the same as above (even the `--flake` option is the same), except default location is `$HOME/.config/home-manager`.

## Detailed presentation

I'll have to write this another time...

## Notes

- This repo is a merge of my previously separated repos for my NixOS and home-manager configs.
- The NixOS config is not very elaborate, I did not tweak very much beyond the default.
- You'll see my commit convention is "\<scope\>: \<[gitmoji](https://gitmoji.dev)\> \<present-tense verb> ...".
    - No scope means treewide implicitly
    - Before the [great merge](https://github.com/C0Florent/config/commit/d1d6f541fa4b04d92c33641f1d7b5d5573545499), I was using the preterit tense.
- FOSS is great. Thanks to every dev which contributed in tools I use (that's a lot of people!)
