# JSON

`std.json` can parse into typed structs, dynamic values, or streams. After
the 0.15 writer overhaul, stringify writes straight into an `Io.Writer`.

```zig
const std = @import("std");

const Config = struct {
    host: []const u8,
    port: u16,
    debug: bool,
};

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const alloc = dbg.allocator();

    // Parse a JSON string into a typed struct
    const src =
        \\{"host": "localhost", "port": 8080, "debug": true}
    ;
    const parsed = try std.json.parseFromSlice(Config, alloc, src, .{});
    defer parsed.deinit();
    const cfg = parsed.value;

    std.debug.print("host: {s}\n", .{cfg.host});
    std.debug.print("port: {d}\n", .{cfg.port});
    std.debug.print("debug: {}\n", .{cfg.debug});

    // Parse into a dynamic Value when the shape isn't known at compile time
    const dynamic = try std.json.parseFromSlice(std.json.Value, alloc, src, .{});
    defer dynamic.deinit();
    if (dynamic.value.object.get("port")) |v| {
        std.debug.print("dynamic port: {d}\n", .{v.integer});
    }

    // Stringify: write into an Io.Writer.Allocating, then read its bytes back.
    var aw: std.Io.Writer.Allocating = .init(alloc);
    defer aw.deinit();
    try std.json.Stringify.value(cfg, .{ .whitespace = .indent_2 }, &aw.writer);
    std.debug.print("{s}\n", .{aw.written()});
}
```

`parseFromSlice` returns a `Parsed(T)` that owns an arena allocator for
the strings inside `T`, so `parsed.deinit()` frees them all in one go.