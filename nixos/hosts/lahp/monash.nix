{ pkgs, lib, ... }:

{
  services.globalprotect = {
    enable = true;

    csdWrapper = "${pkgs.openconnect}/libexec/openconnect/hipreport.sh";
  };

  environment.systemPackages = with pkgs; [
    gpclient
  ];
}
