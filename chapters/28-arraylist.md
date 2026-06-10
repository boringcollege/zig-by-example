# ArrayList

`std.ArrayList(T)` is a growable array backed by an allocator. Since
Zig 0.15 it's *unmanaged* by default — the list itself doesn't hang on to an
allocator, so you pass one in on each mutating call.

```zig
const std = @import("std");

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const alloc = dbg.allocator();

    // 0.15+ : ArrayList is unmanaged by default. Methods take the allocator.
    var list: std.ArrayList(i32) = .empty;
    defer list.deinit(alloc);

    try list.append(alloc, 10);
    try list.append(alloc, 20);
    try list.append(alloc, 30);
    try list.appendSlice(alloc, &.{ 40, 50 });

    std.debug.print("len: {d}\n", .{list.items.len});
    std.debug.print("third: {d}\n", .{list.items[2]});

    // swapRemove is O(1); orderedRemove preserves order at O(n)
    _ = list.swapRemove(0);
    std.debug.print("after remove: {any}\n", .{list.items});

    // Hand out ownership of the backing buffer
    const owned = try list.toOwnedSlice(alloc);
    defer alloc.free(owned);
    std.debug.print("owned: {any}\n", .{owned});
}
```

The unmanaged-by-default change saves a pointer per list and decouples
construction from allocator choice — really handy when the same list type
shows up inside many different arenas.