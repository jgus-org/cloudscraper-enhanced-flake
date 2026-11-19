# cloudscraper-enhanced

A Nix flake that provides [`cloudscraper_enhanced`](https://pypi.org/project/cloudscraper_enhanced/), a Python module that solves Cloudflare anti-bot challenges. It is built as a nixpkgs Python package and imported as `cloudscraper`.

## Outputs

| Attribute          | What you get                                                                            |
| ------------------ | --------------------------------------------------------------------------------------- |
| `overlays.default` | `python3Packages.cloudscraper-enhanced`, built against the package set you apply it to. |

Published for `x86_64-linux`, `aarch64-linux`, `x86_64-darwin`, and `aarch64-darwin`.

```nix
pkgs = import nixpkgs {
  inherit self system;
  overlays = [ cloudscraper-enhanced.overlays.default ];
};

python = pkgs.python3.withPackages (ps: [ ps.cloudscraper-enhanced ]);
```

The recipe resolves in your set, so the module is built for whichever interpreter you join it to and against that set's own releases of its runtime dependencies. This flake's `nixpkgs` input picks the source it fetches and nothing else; it does not pick your interpreter. Upstream requires Python 3.8 or newer.

## Requirements and notes

- Upstream ships js2py as its default JavaScript interpreter. This module does not depend on js2py, so `interpreter="js2py"` fails with `ImportError` when the interpreter is loaded. The bundled pure-Python `native` interpreter (`create_scraper(interpreter="native")`) needs nothing extra; Node.js, ChakraCore, and V8 work if you supply those engines yourself.
- The module's runtime dependencies — requests, requests-toolbelt, pyparsing, pyOpenSSL, pycryptodome, websocket-client, brotli, and certifi — are propagated from the set that carries the module.

See [LICENSE.md](LICENSE.md) for licensing and copyright, and [NOTICE.md](NOTICE.md) for the terms of upstream and distributed artifacts.
