{ lib, pkgs, config, options, mylib, ... }:

let
  cfg = config.mycfg.hypr.superbinds;

  mkSubMap = { catchAllReset ? true, indentLevel ? 0 }: name: binds:
    assert lib.assertMsg (name != "reset") "'reset' is not a valid submap name!";
    let
      indent = lib.concatStrings (lib.replicate indentLevel "  ");
      i = indent;
    in
    ''
      ${i}submap = ${name}

      ${lib.hm.generators.toHyprconf { attrs = binds; indentLevel = indentLevel + 1; }}

      ${i}  ${lib.optionalString catchAllReset "bind = , catchall, submap, reset"}
      ${i}submap = reset
    ''
  ;
in
{
  options = {
    mycfg.hypr.superbinds = {
      enable = lib.mkEnableOption "mycfg.hypr.superbinds" // {
        default = cfg.superbinds != {};
        defaultText = "Whether superbinds.superbinds != {}";
      };

      superbinds = options.wayland.windowManager.hyprland.settings // {
        default = {};
        description = "Hyprland configuration that will be placed in the submap";
      };

      enterBind = lib.mkOption {
        default = { bindr = [ "SUPER, Super_L, submap, ${cfg.submapName}" ]; };
        description = "Hyprland bind used to enter the submap";
      };

      exitBind = lib.mkOption {
        default = { bind = [ ", Escape, submap, reset" ]; };
        description = "Hyprland bind used to exit the submap";
      };

      submapName = lib.mkOption {
        default = "superbinds";
        description = "The name of the Hyprland submap for the superbinds";
        type = lib.types.str;
      };

      mod = lib.mkOption {
        default = "SUPER";
        description = "The Hyprland modifier that will trigger superbinds";
        type = lib.types.str;
      };

      catchAllReset = lib.mkOption {
        default = false;
        description = "Whether any unbound keys should exit the submap";
        type = lib.types.bool;
      };
    };
  };

  config = {
    wayland.windowManager.hyprland =
    let
      actualBinds = lib.filterAttrs
        (n: v: builtins.match ''bind[[:lower:]]*'' n != null)
        cfg.superbinds
      ;
      prefixedBinds = builtins.mapAttrs (n: builtins.map (v: "${cfg.mod} + ${v}")) actualBinds;
    in
    {
      submaps.${cfg.submapName}.settings = mylib.concatAttrSetOfList
        actualBinds
        cfg.exitBind
      ;

      settings = mylib.concatAttrSetOfList cfg.enterBind prefixedBinds;
    };
  };
}
