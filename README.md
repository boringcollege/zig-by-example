# Zig by Example

[![Zig 0.16](https://img.shields.io/badge/zig-0.16-orange.svg)](https://ziglang.org/) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](LICENSE)

**Read online: [boring.college/books/zig-by-example](https://boring.college/books/zig-by-example)**

A hands-on introduction to Zig via annotated examples. Zig is a general-purpose, compiled systems language focused on robustness, optimality, and simplicity — no hidden control flow, no hidden allocations, no preprocessor.

Written by [Dariush Abbasi](https://github.com/dariubs) for [Boring College](https://boring.college)

---

## Layout

- `chapters/NN-name.md` — the annotated chapter
- `examples/NN-name.zig` — the runnable source

Every code block in `chapters/` mirrors the matching `examples/*.zig` file
and has been compiled against the target Zig version.

## Index

1. [Hello, World](https://boring.college/books/zig-by-example/read?chapter=01-hello-world)
2. [Values](https://boring.college/books/zig-by-example/read?chapter=02-values)
3. [Variables](https://boring.college/books/zig-by-example/read?chapter=03-variables)
4. [Integers](https://boring.college/books/zig-by-example/read?chapter=04-integers)
5. [Floats](https://boring.college/books/zig-by-example/read?chapter=05-floats)
6. [Strings](https://boring.college/books/zig-by-example/read?chapter=06-strings)
7. [Arrays](https://boring.college/books/zig-by-example/read?chapter=07-arrays)
8. [Slices](https://boring.college/books/zig-by-example/read?chapter=08-slices)
9. [Vectors](https://boring.college/books/zig-by-example/read?chapter=09-vectors)
10. [Structs](https://boring.college/books/zig-by-example/read?chapter=10-structs)
11. [Enums](https://boring.college/books/zig-by-example/read?chapter=11-enums)
12. [Unions](https://boring.college/books/zig-by-example/read?chapter=12-unions)
13. [Functions](https://boring.college/books/zig-by-example/read?chapter=13-functions)
14. [Blocks and Statements](https://boring.college/books/zig-by-example/read?chapter=14-blocks-and-statements)
15. [If / Else](https://boring.college/books/zig-by-example/read?chapter=15-if-else)
16. [Switch](https://boring.college/books/zig-by-example/read?chapter=16-switch)
17. [While Loops](https://boring.college/books/zig-by-example/read?chapter=17-while-loops)
18. [For Loops](https://boring.college/books/zig-by-example/read?chapter=18-for-loops)
19. [Defer](https://boring.college/books/zig-by-example/read?chapter=19-defer)
20. [Errors](https://boring.college/books/zig-by-example/read?chapter=20-errors)
21. [Optionals](https://boring.college/books/zig-by-example/read?chapter=21-optionals)
22. [Pointers](https://boring.college/books/zig-by-example/read?chapter=22-pointers)
23. [Multi-Pointers](https://boring.college/books/zig-by-example/read?chapter=23-multi-pointers)
24. [Slices (Pointers)](https://boring.college/books/zig-by-example/read?chapter=24-slices-pointers)
25. [Comptime](https://boring.college/books/zig-by-example/read?chapter=25-comptime)
26. [Generics](https://boring.college/books/zig-by-example/read?chapter=26-generics)
27. [Memory Allocation](https://boring.college/books/zig-by-example/read?chapter=27-memory-allocation)
28. [ArrayList](https://boring.college/books/zig-by-example/read?chapter=28-arraylist)
29. [HashMap](https://boring.college/books/zig-by-example/read?chapter=29-hashmap)
30. [Linked List](https://boring.college/books/zig-by-example/read?chapter=30-linked-list)
31. [Testing](https://boring.college/books/zig-by-example/read?chapter=31-testing)
32. [Formatting and Print](https://boring.college/books/zig-by-example/read?chapter=32-formatting-and-print)
33. [Io Interface](https://boring.college/books/zig-by-example/read?chapter=33-io-interface) — *new in 0.16*
34. [Writer & Reader](https://boring.college/books/zig-by-example/read?chapter=34-writer-reader) — *new*
35. [File I/O](https://boring.college/books/zig-by-example/read?chapter=35-file-io)
36. [Threading & Concurrency](https://boring.college/books/zig-by-example/read?chapter=36-threading) — *new*
37. [Processes](https://boring.college/books/zig-by-example/read?chapter=37-processes)
38. [Networking & HTTP](https://boring.college/books/zig-by-example/read?chapter=38-networking) — *new*
39. [JSON](https://boring.college/books/zig-by-example/read?chapter=39-json)
40. [Random Numbers](https://boring.college/books/zig-by-example/read?chapter=40-random-numbers)
41. [Sorting](https://boring.college/books/zig-by-example/read?chapter=41-sorting)
42. [Math](https://boring.college/books/zig-by-example/read?chapter=42-math)
43. [Build System](https://boring.college/books/zig-by-example/read?chapter=43-build-system)
44. [C Interop](https://boring.college/books/zig-by-example/read?chapter=44-c-interop)

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
