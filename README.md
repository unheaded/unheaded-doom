# unheaded-doom

Doom on the Unheaded Protocol Computer: id's engine compiled to MBC bytecode and run by the UPC interpreter in eBPF.

Moved out of `unheaded/unheaded` on 2026-11-04 with its history (DP-305). The UPC itself stays there, along with a fixture of `doom.mbc`, `doom.rv2mbc` and its sha256 for its regression harness.

## Layout

| Path | What |
|---|---|
| `crates/doom-runner` | Aya runtime: loads the object, ROM and WAD, attaches XDP, runs the ring |
| `cmd/doom-ctl` | operator tool; `doom` and `load-mem` came from `wotan-ctl`, the rest is a copy of it |
| `cmd/doom-*`, `internal/` | loaders, bridge, injectors |
| `demos/doom`, `doomgeneric/` | the port and the C sources (GPL-2.0, see `doom/LICENSE`) |
| `docs/doom`, `runbooks/doom` | everything learned, and how to run it |
| `reference/` | the dashboard REST endpoints, kept as text |

## Building

This repository expects `unheaded` checked out at `../../unheaded` relative to it: `go.mod` and `crates/doom-runner/Cargo.toml` use that path for `unheaded/pkg/*` and `crates/upc-api`. So it cannot build on GitHub Actions as it stands (`actions/checkout` cannot write outside the workspace), and no workflow came with it. A `upc-api` change can break `doom-runner` with no gate: rebuild it after one. `doom/doom.elf` here must match the `doom.mbc` and `doom.rv2mbc` fixture in `unheaded`.

    go build ./...
    cd crates/doom-runner && cargo build --release

WAD files are not in this repository.
