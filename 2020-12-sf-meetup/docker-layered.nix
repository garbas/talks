{ pkgs ? import <nixpkgs> {}
, name ? "nix-redis-layered"
, redis ? pkgs.redis
}:

# https://nixos.org/manual/nixpkgs/stable/#ssec-pkgs-dockerTools-buildLayeredImage

let
  inherit (pkgs.dockerTools) buildLayeredImage;

in buildLayeredImage {
  inherit name;
  tag = "latest";

  # https://search.nixos.org/packages
  contents = [
    redis
  ];

  # https://github.com/moby/moby/tree/master/image/spec
  config = { 
    Cmd = [ "/bin/redis-server" ];
    WorkingDir = "/data";
    Volumes = {
      "/data" = {};
    };
  };

  # created = "now";

  # Modern Docker installations support up to 128 layers, however older
  # versions support as few as 42.
  # maxLayers = 100; # maximum 125

  # extraCommands = ''
  #   mkdir -p data
  # '';
}
