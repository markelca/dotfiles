{ config, pkgs, ... }:

{
  imports = [
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/tmux.nix
    ./modules/kitty.nix
    ./modules/fzf.nix
    ./modules/neovim.nix
    # ./modules/fzf.nix
    # ./modules/sway.nix
    # ./modules/i3.nix
  ];
  home.username = "markel";
  home.homeDirectory = "/home/markel";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    hello
    fortune
    nerdfetch
    vim
    tldr
    zoxide
    ripgrep
    stow
    eza
    dig
    bat
    go
    dmenu
    i3status
    acpi
    mako
    libnotify
    nixgl.nixGLIntel # openGL wrapper for nix
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    jetbrains-mono
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/i3/config" = { source = ../dotfiles/i3/config; };
    ".config/sway/config" = { source = ../dotfiles/sway/config; };
    ".local/bin/toggle-keyboard.sh" = {
      source = ../dotfiles/sway/toggle-keyboard.sh;
      executable = true;
    };
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

  # Add Go binaries to PATH
  home.sessionPath = [ 
    "$HOME/go/bin" 
    "$HOME/.npm-global/bin"
    "$HOME/.opencode/bin"
    "$HOME/.local/bin"
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/markel/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { EDITOR = "vim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
