# Code for my talk at SF Meetup, Dec 2020

- [Announcement](https://www.meetup.com/Bay-Area-Nix-NixOS-User-Group/events/275177642/)
- [Presentation](https://docs.google.com/presentation/d/1hTd-P-sukOXsAsmNC64gNQ4bUSXZDB9EXVx2vepdW_w/edit?usp=sharing)

## Agenda

- How / Why do we use Docker?
- Where are the pain-points?
- Why you need to consider Nix?
- Demos:
  - Quick into to Nix (language)

    See intro bellow.

  - How to create isolated development environments without Docker?

    Look at `default.nix`. To enter development environment run:

        nix-shell default.nix

  - How to build Docker images with Nix?

    - Docker image with a single layer

        nix-build docker.nix && docker load -i ./result

    - Docker image with many automatically assigned layers

        nix-build docker-layer.nix && docker load -i ./result

    - How minimal can nix docker images be?

        nix-build docker-layered-minimal.nix && docker load -i ./result
        docker pull redis
        docker pull redis:alpine
        docker images | grep redis

- Q/A

## Quick intro to Nix (language)

Nix in 26 lines (well majority of it).
Helps if you listen to the recorded talk.

```
# this is comment
null
"string"
''multi
line
string''
1
1.5
true
["string" 1 1.5 false ]
{ A = "string"; B = 1; }
{ A = { B = 1; }; } == { A.B = 1; }
rec { A = 1, B = A; }
B = let number = 1; in { A = number; }
inherit (B) A;  # the same as A = B.A;
builtins.getEnv "PATH"
add = a: b: a + b
add 1 2
add2 = { a, b ? 2 }: a + b
add2 { a = 1; }
import ./default.nix
pkgs = import <nixpks> {}
builtins.getEnv "NIX_PATH"
pkgs.redis
[ pkgs.redis ] == with pkgs; [ redis python nodejs ]
"${pkgs.redis}"
```
