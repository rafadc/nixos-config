{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Rafa de Castro";
    userEmail = "rafael@micubiculo.com";
  };
}
