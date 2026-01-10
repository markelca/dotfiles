# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Nix Home Manager-based dotfiles repository with two profiles: `markel` (personal) and `work`. The main difference between profiles is the git email configuration.

## Key Commands

```bash
# Apply personal profile
home-manager switch --flake ~/dotfiles/nix#markel

# Apply work profile
home-manager switch --flake ~/dotfiles/nix#work

# Clone with submodules (neovim config is a submodule)
git clone --recursive https://github.com/MarkelCA/dotfiles.git
```

## Architecture

```
nix/
├── flake.nix          # Nix flake entry point (nixpkgs 24.11, home-manager 24.11)
├── home.nix           # Main Home Manager config, imports all modules
└── modules/           # Tool-specific configurations
    ├── git.nix        # Git config with delta, aliases, profile-based email
    ├── zsh.nix        # Zsh with oh-my-zsh, fzf-tab, zoxide, custom plugins
    ├── tmux.nix       # Tmux with catppuccin theme, vi bindings
    ├── kitty.nix      # Kitty terminal
    └── neovim.nix     # Neovim setup (symlinks nvim/ submodule)

nvim/                  # Git submodule (github.com/MarkelCA/nvim)
├── init.lua           # Entry point, bootstraps lazy.nvim
└── lua/
    ├── config/        # Core config (dvorak remapping, keymaps, options)
    └── plugins/       # 30+ plugin configurations

dotfiles/              # Legacy configs managed via home.file
├── sway/config        # Sway WM (must be installed separately, not via Nix)
└── i3/config          # i3 WM
```

## Important Conventions

- **Dvorak keyboard layout**: All keybindings (sway, i3, neovim) use dvorak-remapped navigation: `n=left, h=down, t=up, s=right`
- **Neovim uses kickstart.nvim patterns** (not LazyVim): Lua-based config with lazy.nvim plugin manager
- **Neovim formatting**: StyLua with 160 column width, spaces, single quotes
- **Sway cannot be installed via Nix** due to home-manager limitations - install via system package manager

## Module System

Each tool in `nix/modules/` follows the pattern:
```nix
{ config, pkgs, ... }: {
  programs.<tool> = {
    enable = true;
    # tool-specific config
  };
}
```

Changes to tools should go in their respective module. New tools need a module file and an import in `home.nix`.
