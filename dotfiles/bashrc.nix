{ config, pkgs, lib, ... }:

{
#  home-manager.users.mudrii = {
    programs = {
      bash = {
        enable = true;
        historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
        historyFileSize = 1000000;
        historySize = 100000;
        initExtra = ''
          source ~/.git-completion.bash
          source ~/.git-prompt.sh
          export INPUTRC=~/.inputrc
          eval "$(direnv hook bash)"
          PS1="\n\[\033[1;32m\]\e[0;31m[\[\e]0;\u@\h: \w\a\]\e[01;32m\u@\[\e[1;34m\]\h:\[\e[01;36m\]\w\[\e[01;32m\]\e[0;31m]\[\033[0m\]\$(__git_ps1)\[\e[01;32m\]\$\[\033[0m\] "
        '';
        shellAliases = {
          ccat = "pygmentize -f terminal256 -g -P style=monokai";
          diff = "diff --color=auto | lless";
          dmesg = "dmesg --color=always | lless";
          gadc = "git add -A; and git commit";
          gad = "git add .";
          gcm = "git commit";
          gch = "git checkout";
          gdf = "git diff";
          gl = "git log";
          glg = "git log --color --graph --pretty --oneline";
          gpl = "git pull";
          gps = "git push";
          gst = "git status";
          la = "exa -alg --group-directories-first -s=type --icons";
          lg = "exa --long --all --group --header --git";
          lt = "exa --long --all --group --header --tree --level ";
          lless = "set -gx LESSOPEN '|pygmentize -f terminal256 -g -P style=monokai %s' && set -gx LESS '-R' && less -m -g -i -J -u -Q";
          rm = "trash-put";
          unrm = "trash-restore";
          rmcl = "trash-empty";
          rml = "trash-list";
          ossw = "sudo nixos-rebuild switch --flake '/etc/nixos/#nixmail' -v";
          hmsw = "home-manager switch --flake ~/.config/nixpkgs/#$USER";
          upa = "nix flake update ~/.config/nixpkgs -v && sudo nix flake update '/etc/nixos/' -v";
          fusw = "upa && ossw && hmsw";
          rusw = "ossw && hmsw";
          ucl = "nix-collect-garbage -d && nix-store --gc && nix-store --repair --verify --check-contents && nix-store --optimise -vvv";
          scl = "sudo nix-collect-garbage -d && sudo nix-store --gc && sudo nix-store --repair --verify --check-contents && sudo nix-store --optimise -vvv";
          acl = "ucl && scl";
        };
      };

      readline = {
        enable = true;
        # bindings = {
        #   "\\e[A" = "history-search-backward";
        #   "\\e[B" = "history-search-forward";
        #   "\\e[C" = "forward-char";
        #   "\\e[D" = "backward-char";
        # };
        extraConfig = ''
          "\e[A": history-search-backward
          "\e[B": history-search-forward
          "\e[C": forward-char
          "\e[D": backward-char
          set match-hidden-files off
          set page-completions off
          set completion-query-items 350
          set completion-ignore-case on
          set show-all-if-ambiguous on
          set bell-style none
          TAB: menu-complete
        '';
      };
    };

    home = {
      file = {
        git-completion = {
          source = ./.git-completion.bash;
          target = ".git-completion.bash";
        };
        git-prompt = {
          source = ./.git-prompt.sh;
          target = ".git-prompt.sh";
        };
      };
    };
#  };
}
