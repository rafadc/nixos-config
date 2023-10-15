{ config, pkgs, ... }:
let
  pkgsUnstable = import <nixpkgs-unstable> { 
    config.allowUnfree = true;
  };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rafadc";
  home.homeDirectory = "/home/rafadc";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  xdg.enable = true;
  xdg.mime.enable = true;

  targets.genericLinux.enable = true;

  home.shellAliases = {
    l = "lsd";
    ll = "lsd -lah";
    v = "lvim";
    k = "kubectl";
    g = "gitui";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true); # Due to https://github.com/nix-community/home-manager/issues/2942
    };
  };

  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    pkgsUnstable.neofetch
    pkgsUnstable.ripgrep
    pkgsUnstable.fd
    pkgsUnstable.fzf
    pkgsUnstable.gitui
    pkgsUnstable.grc
    pkgsUnstable.file

    pkgs.fishPlugins.done
    pkgs.fishPlugins.fzf-fish
    pkgs.fishPlugins.forgit
    pkgs.fishPlugins.grc

    pkgs.python311

    pkgsUnstable.rofi
    pkgsUnstable.rofimoji

    pkgsUnstable.catppuccin-gtk
    pkgsUnstable.gnomeExtensions.user-themes
    pkgsUnstable.gnomeExtensions.paperwm

    pkgs.speechd
    pkgs.firefox

    pkgs.libreoffice
    pkgs.blender
    pkgs.gimp
    pkgs.thunderbird
    pkgs.freefilesync

    pkgsUnstable.kitty

    pkgsUnstable.asdf-vm
    pkgsUnstable.jetbrains-toolbox
    
    pkgsUnstable.neovim
    pkgsUnstable.tree-sitter
    pkgsUnstable.nodePackages_latest.neovim
    pkgsUnstable.python311Packages.pynvim
    
    pkgsUnstable.vscode-with-extensions

    pkgsUnstable.telegram-desktop
    pkgsUnstable.bitwarden
    pkgsUnstable.cura
    pkgsUnstable.obsidian
    pkgsUnstable.flameshot

    pkgsUnstable.zoom
    pkgsUnstable.slack

    pkgs.starship

    pkgs.nerdfonts
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
  };

  programs.starship = { 
    enable = true;
    enableFishIntegration = true;

    settings = {
      # See docs here: https://starship.rs/config/
      # Symbols config configured in Flake.

      character.success_symbol = "[👻 >](bold green)";

      battery.display = [{
        threshold = 25; # display battery information if charge is <= 25%
      }];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rafadc/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
