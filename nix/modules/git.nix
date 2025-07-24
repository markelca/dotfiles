{ profileName, ... }:

{
  programs.git = {
    enable = true;
    userName = "Markel Cuesta";
    userEmail = if profileName == "work" 
                then "markel.cuesta@roadsurfer.com" 
                else "cuesta.markel@proton.me";

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
      };
    };

    extraConfig = {
      push = { autoSetupRemote = true; };
      core = {
        editor = "vim";
      };
      rerere = {
        enabled = false;
        autoupdate = true;
      };
      branch = { sort = "-committerdate"; };
      maintenance = { repo = "/home/markel/.dotfiles"; };
      merge = { conflictStyle = "zdiff3"; };
    };

    aliases = {
      co = "checkout";
      ci = "commit";
      st = "status";
      br = "branch -av";
      staash = "stash --all"; # Also stashes untracked files
      bb =
        "!~/bin/better-git-branch.sh"; # More friendly branch list (only local branches)
      pushf = "push --force-with-lease --force-if-includes";
      aliases =
        "!git config --list | grep 'alias\\.' | sed 's/alias\\.\\([^=]*\\)=\\(.*\\)/\\1\\ 	 => \\2/' | sort";
      lg =
        "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    };

    ignores = [
      ".obsidian"
      ".phpactor.json"
      "# Node.js"
      "node_modules/"
      "npm-debug.log*"
      "yarn-debug.log*"
      "yarn-error.log*"
      "pnpm-debug.log*"
      ".env"
      "dist/"
      "build/"
      "*.log"
      "coverage/"
      ".vscode/"
      ".DS_Store"
      "# Python"
      "__pycache__/"
      "*.py[cod]"
      "*.pyo"
      "*.pyd"
      ".Python"
      "env/"
      "venv/"
      "ENV/"
      "env.bak/"
      "*.log"
      ".mypy_cache/"
      ".pytest_cache/"
      ".idea/"
      "local_settings.py"
      "# PHP"
      "/vendor/"
      "# General"
      "Thumbs.db"
      ".DS_Store"
      "*.swp"
      "*.swo"
      "*.bak"
      "*.tmp"
      "*.orig"
      "*.log"
      "*.log.*"
      "*.stackdump"
      "*.log.bak"
      "# IDEs/Editors"
      ".vscode/"
      ".idea/"
      "*.sublime-workspace"
      "*.sublime-project"
      "*.iml"
      "# Operating System"
      ".DS_Store"
      "Desktop.ini"
      "docker-compose.override.yml"
    ];
  };
}
