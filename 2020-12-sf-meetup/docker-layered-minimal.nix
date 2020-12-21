{ pkgs ? import <nixpkgs> {}
}:

(import ./docker-layered.nix) {
  inherit pkgs;

  name = "nix-redis-layered-minimal";

  redis = pkgs.redis.overrideAttrs (old: {
    # no need for systemd support in our docker image
    makeFlags = old.makeFlags ++ ["USE_SYSTEMD=no"];
    # build static binary with musl
    preBuild = ''
      makeFlagsArray=(PREFIX="$out"
                      CC="${pkgs.musl.dev}/bin/musl-gcc -static"
                      CFLAGS="-I${pkgs.musl.dev}/include"
                      LDFLAGS="-L${pkgs.musl.dev}/lib")
    '';
    # Let's remove some binaries which we don't need
    postInstall = "rm -f $out/bin/redis-{benchmark,check-*,cli}";
  });
}
