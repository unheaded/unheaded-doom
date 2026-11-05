# Architecture Compatibility

## Supported: x86_64 + arm64 (aarch64) Linux

Both little-endian. All doom code runs on either without modification.

## Endianness Map

| Layer | Byte Order | Why |
|-------|-----------|-----|
| BPF maps (keys, values) | Little-endian | Host byte order, both arches are LE |
| MBC CPU state (`MbcCpuState`) | Little-endian | `repr(C)` struct, LE fields |
| MBC ROM instructions | Little-endian | u32 LE words |
| IPv6 headers / Ethernet | Big-endian | Network byte order (RFC standard) |
| Monad register (wire) | Big-endian | Network byte order per spec |
| `AF_PACKET` sockaddr | Mixed | `sll_family`/`sll_ifindex` = host LE, `sll_protocol` = network BE |

## Struct Padding: `MbcCpuState`

```
Offset  Size  Field
0       64    regs: [u32; 16]
64       4    pc: u32
68       1    flags: u8
69       1    halted: u8
70       1    stalled: u8
71       1    _pad: u8          ← EXPLICIT padding for u64 alignment
72       8    sleep_until_ns: u64
80       8    insn_count: u64
88       8    cache_hits: u64
96       8    cache_misses: u64
= 104 bytes total
```

The `_pad` byte ensures `sleep_until_ns` lands at offset 72 (8-byte aligned)
on BOTH x86_64 and arm64. Without it, arm64's stricter alignment requirements
would insert implicit padding, breaking Go's hardcoded offsets.

Go code in `pkg/doom/types.go` and `pkg/bpf/bpf.go` uses `binary.LittleEndian`
explicitly — never `unsafe.Pointer` casts. This is endian-safe by construction.

## Would Break On

- Big-endian Linux (s390x, armeb, mips BE) — BPF map serialization assumes LE
- eBPF target is `bpfel` — would need `bpfeb` builds for BE kernels
- Any arch where `repr(C)` adds different padding (none known with `_pad` present)

## Key Design Decisions

1. All BPF map I/O uses Go's `encoding/binary` with explicit endianness — no `unsafe`
2. Network wire format uses `BigEndian` per IPv6/Ethernet standards
3. `repr(C)` + explicit `_pad` byte = identical layout across x86_64 and arm64
4. `htons()` in doom-go-injector handles host→network conversion correctly on both
