# Optionals

An optional `?T` holds either a value of type `T` or `null`. It isn't a
pointer — `?T` has its own null state, separate from any valid `T` value.

```zig
const std = @import("std");

fn findFirst(haystack: []const u8, needle: u8) ?usize {
    for (haystack, 0..) |c, i| {
        if (c == needle) return i;
    }
    return null;
}

pub fn main() void {
    const s = "hello world";

    // if capture
    if (findFirst(s, 'o')) |idx| {
        std.debug.print("found at {d}\n", .{idx}); // 4
    }

    // orelse — fallback value
    const idx = findFirst(s, 'z') orelse s.len;
    std.debug.print("idx: {d}\n", .{idx});

    // .? — unwrap or panic
    const guaranteed = findFirst(s, 'e').?;
    std.debug.print("guaranteed: {d}\n", .{guaranteed});

    // orelse chaining
    const maybe: ?i32 = null;
    const val = maybe orelse 99;
    std.debug.print("val: {d}\n", .{val});
}
```