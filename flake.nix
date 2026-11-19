{
  description = "Enhanced Python module for Cloudflare challenge handling";

  inputs = {
    flake-lib.url = "github:jgus-org/flake-lib/v1";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      flake-lib,
      nixpkgs,
    }:
    flake-lib.lib.mkPythonFlake {
      inherit nixpkgs self;
      payload.overlays =
        {
          buildPackage,
          pkgs,
          python,
          ...
        }:
        {
          cloudscraper-enhanced = buildPackage {
            dependencies = [
              python.brotli
              python.certifi
              python.pycryptodome
              python.pyopenssl
              python.pyparsing
              python.requests
              python.requests-toolbelt
              python.websocket-client
            ];
            meta = {
              description = "Enhanced Python module for Cloudflare challenge handling";
              license = pkgs.lib.licenses.mit;
            };
            # Retire once upstream's native.py reads number literals from ast.Constant itself.
            patches = [ ./native-interpreter-ast-constant.patch ];
            pname = "cloudscraper-enhanced";
            pythonRemoveDeps = [ "js2py" ];
          };
        };
      upstream = {
        format = "sdist";
        pin = import ./pin.nix;
        pname = "cloudscraper_enhanced";
        type = "pypi";
      };
    };
}
