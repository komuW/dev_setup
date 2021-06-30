with (import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21.05.tar.gz") {});

/*
  Alternative are:
   (a) { pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21.05.tar.gz") {} }:
   (b) { pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/4795e7f3a9cebe277bb4b5920caa8f0a2c313eb0.tar.gz") {} }:
   (c) with (import <nixpkgs> {});

*/

/*
    docs:
    1. https://nixos.org/manual/nix/stable/#chap-writing-nix-expressions
    2. https://nixos.org/guides/declarative-and-reproducible-developer-environments.html#declarative-reproducible-envs
    3. https://nixos.org/guides/towards-reproducibility-pinning-nixpkgs.html
    4. https://ghedam.at/15978/an-introduction-to-nix-shell
    5. https://nix.dev/tutorials/declarative-and-reproducible-developer-environments.html

    usage:
    - from this directory, run;
        MY_NAME=$(whoami)
        /nix/var/nix/profiles/per-user/$MY_NAME/profile/bin/nix-shell
*/


let
  basePackages = [ ];
  
  htopPath = ./htop.nix;
  vlcPath = ./htop.nix;
  preRequistePath  = ./preRequiste.nix;

  inputs = basePackages 
    ++ lib.optional (builtins.pathExists preRequistePath) (import preRequistePath {}).inputs
    ++ lib.optional (builtins.pathExists htopPath) (import htopPath {}).inputs
    ++ lib.optional (builtins.pathExists vlcPath) (import vlcPath {}).inputs;

  baseHooks = "echo 'hello from default.nix;'";

  shellHooks = baseHooks
    + lib.optionalString (builtins.pathExists preRequistePath) (import preRequistePath {}).hooks
    + lib.optionalString (builtins.pathExists htopPath) (import htopPath {}).hooks
    + lib.optionalString (builtins.pathExists vlcPath) (import vlcPath {}).hooks;

in mkShell {
  buildInputs = inputs;
  shellHook = shellHooks;
}


# TODO: remove when done
# /bin/bash preRequiste.sh
# /bin/bash user.sh "$USER_PASSWORD"
# /bin/bash provision.sh
# /bin/bash version_control.sh "$PERSONAL_WORK_EMAIL" "$PERSONAL_WORK_NAME"
# /bin/bash setup_ssh.sh "$SSH_KEY_PHRASE_PERSONAL" "$SSH_KEY_PHRASE_PERSONAL_WORK" "$PERSONAL_WORK_EMAIL"
# /bin/bash golang.sh
# /bin/bash vscode.sh
# /bin/bash dart.sh
# /bin/bash media.sh
# /bin/bash tools.sh
# /bin/bash ohmyz.sh
# /bin/bash java.sh
# /bin/bash clean_up.sh
