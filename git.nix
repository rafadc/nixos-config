{ pkgs, ... }:

{
  home.packages = with pkgs.gitAndTools; [
    diff-so-fancy # git diff with colors
    git-crypt # git files encryption
    hub # github command-line client
  ];


  programs.git = {
    extraConfig.init.defaultBranch = "main";
    enable = true;
    lfs.enable = true;
    userName = "Rafa de Castro";
    userEmail = "rafael@micubiculo.com";
  };
}
