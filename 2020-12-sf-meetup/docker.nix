{ pkgs ? import <nixpkgs> {}
}:

# https://nixos.org/manual/nixpkgs/stable/#ssec-pkgs-dockerTools-buildImage

let
  inherit (pkgs.dockerTools) buildImage;

in buildImage {
  name = "nix-redis";
  tag = "latest";

  # https://search.nixos.org/packages
  contents = with pkgs; [
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

  # more options see buildImage documentation
  created = "now";
  # fromImage = someBaseImage;  # docker export or pullImage
  # fromImageName = "alpine";
  # fromImageTag = "latest";
  # runAsRoot = ''
  #   #!${pkgs.runtimeShell}
  #   mkdir -p /data"
  # '';  # like RUN in dockerfile (requires KVM device)

}
