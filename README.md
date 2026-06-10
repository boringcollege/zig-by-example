# Zig by Example

[![Zig 0.16](https://img.shields.io/badge/zig-0.16-orange.svg)](https://ziglang.org/) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](LICENSE)

A hands-on introduction to Zig via annotated examples. Zig is a general-purpose, compiled systems language focused on robustness, optimality, and simplicity — no hidden control flow, no hidden allocations, no preprocessor.

Written by [Dariush Abbasi](https://github.com/dariubs) for [Boring College](https://boring.college)

---

## Layout

- `chapters/NN-name.md` — the annotated chapter
- `examples/NN-name.zig` — the runnable source

Every code block in `chapters/` mirrors the matching `examples/*.zig` file
and has been compiled against the target Zig version.

## Index

1. [Hello, World](chapters/01-hello-world.md)
2. [Values](chapters/02-values.md)
3. [Variables](chapters/03-variables.md)
4. [Integers](chapters/04-integers.md)
5. [Floats](chapters/05-floats.md)
6. [Strings](chapters/06-strings.md)
7. [Arrays](chapters/07-arrays.md)
8. [Slices](chapters/08-slices.md)
9. [Vectors](chapters/09-vectors.md)
10. [Structs](chapters/10-structs.md)
11. [Enums](chapters/11-enums.md)
12. [Unions](chapters/12-unions.md)
13. [Functions](chapters/13-functions.md)
14. [Blocks and Statements](chapters/14-blocks-and-statements.md)
15. [If / Else](chapters/15-if-else.md)
16. [Switch](chapters/16-switch.md)
17. [While Loops](chapters/17-while-loops.md)
18. [For Loops](chapters/18-for-loops.md)
19. [Defer](chapters/19-defer.md)
20. [Errors](chapters/20-errors.md)
21. [Optionals](chapters/21-optionals.md)
22. [Pointers](chapters/22-pointers.md)
23. [Multi-Pointers](chapters/23-multi-pointers.md)
24. [Slices (Pointers)](chapters/24-slices-pointers.md)
25. [Comptime](chapters/25-comptime.md)
26. [Generics](chapters/26-generics.md)
27. [Memory Allocation](chapters/27-memory-allocation.md)
28. [ArrayList](chapters/28-arraylist.md)
29. [HashMap](chapters/29-hashmap.md)
30. [Linked List](chapters/30-linked-list.md)
31. [Testing](chapters/31-testing.md)
32. [Formatting and Print](chapters/32-formatting-and-print.md)
33. [Io Interface](chapters/33-io-interface.md) — *new in 0.16*
34. [Writer & Reader](chapters/34-writer-reader.md) — *new*
35. [File I/O](chapters/35-file-io.md)
36. [Threading & Concurrency](chapters/36-threading.md) — *new*
37. [Processes](chapters/37-processes.md)
38. [Networking & HTTP](chapters/38-networking.md) — *new*
39. [JSON](chapters/39-json.md)
40. [Random Numbers](chapters/40-random-numbers.md)
41. [Sorting](chapters/41-sorting.md)
42. [Math](chapters/42-math.md)
43. [Build System](chapters/43-build-system.md)
44. [C Interop](chapters/44-c-interop.md)

---

## Running the examples

Install Zig 0.16.0 — `brew install zig` on macOS, or grab a tarball from
[ziglang.org/download](https://ziglang.org/download/). Then:

```
$ zig run examples/01-hello-world.zig
Hello, World!
```

A few examples need extra flags:

```
$ zig test examples/31-testing.zig            # tests
$ zig run  examples/44-c-interop.zig -lc      # link libc
```

## Further Reading

- [Zig Official Documentation](https://ziglang.org/documentation/master/)
- [Zig Standard Library Source](https://github.com/ziglang/zig/tree/master/lib/std)
- [Zig 0.15.1 Release Notes](https://ziglang.org/download/0.15.1/release-notes.html) — Writergate, unmanaged collections
- [Zig 0.16.0 Release Notes](https://ziglang.org/download/0.16.0/release-notes.html) — the `Io` interface
- [Ziglings — exercises](https://codeberg.org/ziglings/exercises)

---

*Zig by Example* is inspired by [Go by Example](https://gobyexample.com) by Mark McGranaghan. Examples target **Zig 0.16**.

Contributions welcome — see [CONTRIBUTING.md](CONTRIBUTING.md).
