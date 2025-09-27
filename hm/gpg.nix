{ ... }:

{
  programs.gpg = {
    enable = true;

    settings = {
      pinentry-mode = "loopback";
    };
  };

  services.gpg-agent = {
    enable = true;
  };
}
