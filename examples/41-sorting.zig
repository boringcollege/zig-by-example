const std = @import("std");

pub fn main() void {
    var nums = [_]i32{ 5, 3, 8, 1, 9, 2, 7, 4, 6 };

    std.mem.sort(i32, &nums, {}, std.sort.asc(i32));
    std.debug.print("asc:  {any}\n", .{nums});

    std.mem.sort(i32, &nums, {}, std.sort.desc(i32));
    std.debug.print("desc: {any}\n", .{nums});

    // Custom comparator with a struct of orderable values
    const Pair = struct { key: u32, val: []const u8 };
    var pairs = [_]Pair{
        .{ .key = 3, .val = "three" },
        .{ .key = 1, .val = "one" },
        .{ .key = 2, .val = "two" },
    };

    const byKey = struct {
        fn lessThan(_: void, a: Pair, b: Pair) bool {
            return a.key < b.key;
        }
    }.lessThan;

    std.mem.sort(Pair, &pairs, {}, byKey);
    for (pairs) |p| std.debug.print("{d}: {s}\n", .{ p.key, p.val });

    // Binary search — slice must already be sorted
    const sorted = [_]i32{ 1, 3, 5, 7, 9, 11 };
    const pos = std.sort.binarySearch(i32, &sorted, @as(i32, 7), struct {
        fn order(key: i32, mid: i32) std.math.Order {
            return std.math.order(key, mid);
        }
    }.order);
    std.debug.print("found 7 at: {?d}\n", .{pos});
}
