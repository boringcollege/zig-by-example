const std = @import("std");

pub fn main() void {
    // String literal — type is *const [N:0]u8, coerces to []const u8
    const hello: []const u8 = "Hello, Zig!";

    std.debug.print("{s}\n", .{hello});
    std.debug.print("length: {d}\n", .{hello.len});
    std.debug.print("first byte: {d}\n", .{hello[0]});

    // String equality
    const a = "foo";
    const b = "foo";
    std.debug.print("equal: {}\n", .{std.mem.eql(u8, a, b)});

    // Multi-line string literal uses \\
    const poem =
        \\Roses are red,
        \\Violets are blue,
        \\Zig has no GC,
        \\and that's awesome too.
    ;
    std.debug.print("{s}\n", .{poem});
}
