{ pkgs, lib, config, ... }:

let
  cfg = config.mycfg.sanedefaults;
in
{
  options.mycfg.sanedefaults = {
    enable = lib.mkEnableOption "sane defaults";

    applyFunction = lib.mkOption {
      description = ''
        A function that will be applied to all final
        attributes set by this module
      '';
      default = lib.mkDefault;
      defaultText = "Identity function";
      example = lib.literalExpression "lib.mkForce";
    };

    excludePackages = lib.mkOption {
      description = "List of packages to exclude from the default-installed ones";
      default = [ ];
      example = lib.literalExpression ''[ "neofetch" pkgs.moreutils ]'';
    };
  };

  config = let
    defPkgs = with pkgs; [
      moreutils

      neofetch

      stdmanpages
      linux-manual
      man-pages
      vlc
    ];

    defPkgsNames = builtins.map lib.getName defPkgs;
    excludePkgsNames = builtins.map lib.getName cfg.excludePackages;

    excludeNonDefaults = builtins.filter (pkg: !builtins.elem pkg defPkgsNames) excludePkgsNames;
  in lib.mkIf cfg.enable {
    warnings = lib.optional (excludeNonDefaults != [ ]) ''
      Some packages in mycfg.sanedefaults.excludePackages are not in the default pacakges: [${builtins.toString excludeNonDefaults}]
    '';
    boot.loader.systemd-boot.enable = cfg.applyFunction true;

    networking.networkmanager.enable = true;

    programs.firefox.enable = cfg.applyFunction true;

    services.displayManager.sddm.enable = cfg.applyFunction true;
    services.desktopManager.plasma6.enable = cfg.applyFunction true;

    services.xserver = {
      enable = cfg.applyFunction true;

      xkb = cfg.applyFunction {
        layout = "fr";
        variant = "oss";
      };
    };

    nix.settings.experimental-features = cfg.applyFunction "nix-command flakes pipe-operators";

    programs.git = {
      enable = cfg.applyFunction true;

      prompt.enable = cfg.applyFunction true;
      config = {
        init.defaultBranch = cfg.applyFunction "main";
        push.autoSetupRemote = cfg.applyFunction true;
        pull.rebase = cfg.applyFunction true;
      };
    };

    services.printing.enable = true;

    # Various sound-related options, which are in the initial
    # config of the NixOS plasma installer
    services.pulseaudio.enable = cfg.applyFunction false;
    security.rtkit.enable = cfg.applyFunction true;
    services.pipewire = {
      enable = cfg.applyFunction true;
      alsa.enable = cfg.applyFunction true;
      alsa.support32Bit = cfg.applyFunction true;
      pulse.enable = cfg.applyFunction true;

      jack.enable = cfg.applyFunction true;
    };

    programs.vim = {
      enable = cfg.applyFunction true;

      package = cfg.applyFunction pkgs.vim-full;
      defaultEditor = cfg.applyFunction true;
    };

    environment.systemPackages = builtins.filter
      (pkg: !builtins.elem (lib.getName pkg) excludePkgsNames)
      defPkgs
    ;
  };
}
