# Slices

A slice is a pointer paired with a length: `[]T`. Slices don't own their memory.

```zig
const std = @import("std");

pub fn main() void {
    var arr = [_]i32{ 10, 20, 30, 40, 50 };

    // Slice of the whole array
    const s: []i32 = arr[0..];
    std.debug.print("len: {d}\n", .{s.len});

    // Sub-slice [start..end) — end is exclusive
    const mid = arr[1..4];
    std.debug.print("mid: {any}\n", .{mid});

    // Slices are just fat pointers — modifying through the slice changes the array
    s[0] = 99;
    std.debug.print("arr[0] = {d}\n", .{arr[0]}); // 99

    // Passing a slice to a function
    std.debug.print("total: {d}\n", .{sum(s)});
}

fn sum(nums: []const i32) i32 {
    var total: i32 = 0;
    for (nums) |n| total += n;
    return total;
}
```