# HashMap

`std.AutoHashMap(K, V)` handles integer and pointer keys for you.
For string keys, reach for `std.StringHashMap(V)` instead.

```zig
const std = @import("std");

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const alloc = dbg.allocator();

    var map: std.AutoHashMap(u32, []const u8) = .init(alloc);
    defer map.deinit();

    try map.put(1, "one");
    try map.put(2, "two");
    try map.put(3, "three");

    if (map.get(2)) |val| {
        std.debug.print("2 => {s}\n", .{val});
    }

    // getOrPut — insert a default if absent
    const gop = try map.getOrPut(4);
    if (!gop.found_existing) gop.value_ptr.* = "four";
    std.debug.print("4 => {s}\n", .{map.get(4).?});

    _ = map.remove(1);

    var it = map.iterator();
    while (it.next()) |entry| {
        std.debug.print("{d} => {s}\n", .{ entry.key_ptr.*, entry.value_ptr.* });
    }

    // String keys — use StringHashMap
    var smap: std.StringHashMap(u32) = .init(alloc);
    defer smap.deinit();
    try smap.put("apple", 1);
    try smap.put("pear", 2);
    std.debug.print("apple = {d}\n", .{smap.get("apple").?});
}
```