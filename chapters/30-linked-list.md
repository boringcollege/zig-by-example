# Linked List

As of 0.15+, `std.DoublyLinkedList` is *de-genericified* — the list works on
embedded `Node` pointers rather than values. You drop a `Node` field into
your own struct, then recover the parent with `@fieldParentPtr`.

```zig
const std = @import("std");

const Item = struct {
    value: i32,
    node: std.DoublyLinkedList.Node = .{},
};

pub fn main() void {
    var list: std.DoublyLinkedList = .{};

    var a: Item = .{ .value = 10 };
    var b: Item = .{ .value = 20 };
    var c: Item = .{ .value = 30 };

    list.append(&a.node);
    list.append(&b.node);
    list.append(&c.node);

    // Forward iteration
    var it = list.first;
    while (it) |n| : (it = n.next) {
        const parent: *Item = @fieldParentPtr("node", n);
        std.debug.print("{d}\n", .{parent.value});
    }

    // Remove a node — pointers are unaffected, list shrinks
    list.remove(&b.node);
    std.debug.print("after removing 20:\n", .{});
    it = list.first;
    while (it) |n| : (it = n.next) {
        const parent: *Item = @fieldParentPtr("node", n);
        std.debug.print("{d}\n", .{parent.value});
    }
}
```

This intrusive design lets the same node sit in multiple lists with no
extra allocations — the trade-off being a slightly less ergonomic API.