# Writer & Reader

`std.Io.Writer` and `std.Io.Reader` are the byte-stream interfaces. They
come with one twist most other languages don't have: **the buffer lives
inside the interface itself**, not in a separate `BufferedWriter` wrapper.
That keeps the optimizer happy and rules out a class of double-buffer bugs.

```zig
const std = @import("std");

// Custom format method — new 0.15+ signature: only the writer.
const Point = struct {
    x: i32,
    y: i32,

    pub fn format(p: Point, w: *std.Io.Writer) std.Io.Writer.Error!void {
        try w.print("({d}, {d})", .{ p.x, p.y });
    }
};

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const gpa = dbg.allocator();

    var io_impl: std.Io.Threaded = .init(gpa, .{});
    defer io_impl.deinit();
    const io = io_impl.io();

    // 1. Writer to stdout. The buffer lives on the stack; flush before exit.
    var out_buf: [4096]u8 = undefined;
    var out_file = std.Io.File.stdout().writer(io, &out_buf);
    const out = &out_file.interface;
    defer out.flush() catch {};

    try out.print("plain string: {s}\n", .{"hi"});
    try out.print("number: {d}\n", .{42});

    // Types with a `format` method print via {f} — the explicit `f` makes
    // calls to custom formatters visible at the call site.
    const p: Point = .{ .x = 3, .y = 4 };
    try out.print("point: {f}\n", .{p});

    // 2. Writer.Allocating — grows a heap buffer, returns owned bytes.
    var alloc_writer: std.Io.Writer.Allocating = .init(gpa);
    defer alloc_writer.deinit();
    const w = &alloc_writer.writer;

    try w.print("line {d}\n", .{1});
    try w.print("line {d}\n", .{2});

    try out.print("collected:\n{s}", .{alloc_writer.written()});

    // 3. Reader over a fixed slice — for parsing in-memory bytes.
    var src: std.Io.Reader = .fixed("alpha,beta,gamma");
    while (try src.takeDelimiter(',')) |field| {
        try out.print("field: {s}\n", .{field});
    }
}
```

## Three flavors of writer

| Use case                        | Type                            |
|---------------------------------|---------------------------------|
| stdout, file, network socket    | construct one via `.writer(io, &buf)` |
| Build a string in memory        | `std.Io.Writer.Allocating`      |
| Wrap an existing `[]u8`         | `std.Io.Writer.fixed(buf)`      |

## Why `{f}` for custom format methods?

In 0.14, every `{}` could quietly dispatch to a custom `format` function,
so refactors sometimes changed behavior without warning. From 0.15 onward,
`{f}` is required to call a `format` method — accidental dispatch is now a
compile error.

Source: [examples/34-writer-reader.zig](../examples/34-writer-reader.zig)

---
[← Previous](33-io-interface.md) | [Index](../README.md) | [Next →](35-file-io.md)
