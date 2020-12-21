{ pkgs ? import <nixpkgs> {}
}:

let
  #inherit (pkgs) mkShell;
  mkShell = pkgs.mkShell;
in 

mkShell {
  name = "my-dev-env";
  buildInputs = [
    pkgs.redis
    pkgs.python
    pkgs.go
  ];
}
