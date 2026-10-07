{ pkgs, lib, ... }:

{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  users.groups.libvirtd.members = [ "fcharpentier" ];
  virtualisation.spiceUSBRedirection.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # virt-manager networks need to be started imperatively,
  # so we declare a systemd service to do it for us
  systemd.services.libvirt-default-network = {
    description = "Start libvirt default network";
    after = ["libvirtd.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${lib.getExe' pkgs.libvirt "virsh"} net-start default";
      ExecStop = "${lib.getExe' pkgs.libvirt "virsh"} net-destroy default";
      User = "root";
    };
  };
}
