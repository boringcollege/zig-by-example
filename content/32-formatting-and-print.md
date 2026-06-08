# Formatting and Print

`std.debug.print` writes to stderr with zero setup — great for quick
debugging. For **stdout**, you'll build a `Writer` on top of the new I/O
interface (introduced in 0.15 as "Writergate" and threaded through `Io`
in 0.16). And don't forget to `flush`.

```zig
const std = @import("std");

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const alloc = dbg.allocator();

    var io_impl: std.Io.Threaded = .init(alloc, .{});
    defer io_impl.deinit();
    const io = io_impl.io();

    // The new Writer interface owns its buffer. `flush` is no longer optional.
    var out_buf: [4096]u8 = undefined;
    var out_writer = std.Io.File.stdout().writer(io, &out_buf);
    const out = &out_writer.interface;
    defer out.flush() catch {};

    // Default formatting
    try out.print("Hello, {s}!\n", .{"world"});

    // Integer specifiers
    try out.print("decimal: {d}\n", .{255});
    try out.print("hex:     {x}\n", .{255}); // ff
    try out.print("HEX:     {X}\n", .{255}); // FF
    try out.print("octal:   {o}\n", .{255}); // 377
    try out.print("binary:  {b}\n", .{255}); // 11111111

    // Float specifiers
    try out.print("default: {d}\n", .{3.14159});
    try out.print("fixed:   {d:.2}\n", .{3.14159}); // 3.14
    try out.print("sci:     {e:.2}\n", .{12345.0}); // 1.23e4

    // Width and padding
    try out.print("|{d:>10}|\n", .{42}); // right-align
    try out.print("|{d:<10}|\n", .{42}); // left-align
    try out.print("|{d:0>6}|\n", .{42}); // zero-pad to width 6

    // Whole-value default
    try out.print("{any}\n", .{[_]u8{ 1, 2, 3 }});

    // Format into a stack buffer
    var buf: [64]u8 = undefined;
    const s = try std.fmt.bufPrint(&buf, "{d} + {d} = {d}", .{ 1, 2, 3 });
    try out.print("{s}\n", .{s});

    // Format into an allocated string
    const msg = try std.fmt.allocPrint(alloc, "value = {d}", .{42});
    defer alloc.free(msg);
    try out.print("{s}\n", .{msg});
}
```

Specifier cheat sheet:

| Form     | Meaning                                |
|----------|----------------------------------------|
| `{}`     | Default for primitives                 |
| `{d}`    | Decimal integer/float                  |
| `{x}` / `{X}` | Lower/upper-case hex              |
| `{o}` / `{b}` | Octal / binary                    |
| `{e}`    | Scientific notation                    |
| `{s}`    | UTF-8 / ASCII slice                    |
| `{c}`    | Single ASCII byte                      |
| `{any}`  | Generic fallback                       |
| `{f}`    | Call a type's custom `format` method   |

Source: [examples/32-formatting-and-print.zig](../examples/32-formatting-and-print.zig)

---
[← Previous](31-testing.md) | [Index](../README.md) | [Next →](33-io-interface.md)
