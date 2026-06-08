# Zig by Example

[![Zig 0.16](https://img.shields.io/badge/zig-0.16-orange.svg)](https://ziglang.org/) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](LICENSE)

A hands-on introduction to Zig via annotated examples. Zig is a general-purpose, compiled systems language focused on robustness, optimality, and simplicity — no hidden control flow, no hidden allocations, no preprocessor.

Written by [Dariush Abbasi](https://github.com/dariubs) for [Boring College](https://boring.college)

---

## Layout

- `content/NN-name.md` — the annotated chapter
- `examples/NN-name.zig` — the runnable source

Every code block in `content/` mirrors the matching `examples/*.zig` file
and has been compiled against the target Zig version.

## Index

1. [Hello, World](content/01-hello-world.md)
2. [Values](content/02-values.md)
3. [Variables](content/03-variables.md)
4. [Integers](content/04-integers.md)
5. [Floats](content/05-floats.md)
6. [Strings](content/06-strings.md)
7. [Arrays](content/07-arrays.md)
8. [Slices](content/08-slices.md)
9. [Vectors](content/09-vectors.md)
10. [Structs](content/10-structs.md)
11. [Enums](content/11-enums.md)
12. [Unions](content/12-unions.md)
13. [Functions](content/13-functions.md)
14. [Blocks and Statements](content/14-blocks-and-statements.md)
15. [If / Else](content/15-if-else.md)
16. [Switch](content/16-switch.md)
17. [While Loops](content/17-while-loops.md)
18. [For Loops](content/18-for-loops.md)
19. [Defer](content/19-defer.md)
20. [Errors](content/20-errors.md)
21. [Optionals](content/21-optionals.md)
22. [Pointers](content/22-pointers.md)
23. [Multi-Pointers](content/23-multi-pointers.md)
24. [Slices (Pointers)](content/24-slices-pointers.md)
25. [Comptime](content/25-comptime.md)
26. [Generics](content/26-generics.md)
27. [Memory Allocation](content/27-memory-allocation.md)
28. [ArrayList](content/28-arraylist.md)
29. [HashMap](content/29-hashmap.md)
30. [Linked List](content/30-linked-list.md)
31. [Testing](content/31-testing.md)
32. [Formatting and Print](content/32-formatting-and-print.md)
33. [Io Interface](content/33-io-interface.md) — *new in 0.16*
34. [Writer & Reader](content/34-writer-reader.md) — *new*
35. [File I/O](content/35-file-io.md)
36. [Threading & Concurrency](content/36-threading.md) — *new*
37. [Processes](content/37-processes.md)
38. [Networking & HTTP](content/38-networking.md) — *new*
39. [JSON](content/39-json.md)
40. [Random Numbers](content/40-random-numbers.md)
41. [Sorting](content/41-sorting.md)
42. [Math](content/42-math.md)
43. [Build System](content/43-build-system.md)
44. [C Interop](content/44-c-interop.md)

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
