const std = @import("std");
const testing = std.testing;

fn factorial(n: u64) u64 {
    if (n == 0) return 1;
    return n * factorial(n - 1);
}

test "factorial of 0" {
    try testing.expectEqual(@as(u64, 1), factorial(0));
}

test "factorial of 5" {
    try testing.expectEqual(@as(u64, 120), factorial(5));
}

test "factorial of 10" {
    try testing.expectEqual(@as(u64, 3_628_800), factorial(10));
}

test "arraylist with testing.allocator" {
    var list: std.ArrayList(i32) = .empty;
    defer list.deinit(testing.allocator);

    try list.append(testing.allocator, 1);
    try list.append(testing.allocator, 2);
    try testing.expectEqual(@as(usize, 2), list.items.len);
}

// A `main` lets `zig run` succeed; the file is meant to be used with `zig test`.
pub fn main() void {
    std.debug.print("run me with: zig test examples/31-testing.zig\n", .{});
}
