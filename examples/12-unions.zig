const std = @import("std");

// Bare union — you track the active field yourself
const FloatOrInt = union {
    float: f64,
    int: i64,
};

// Tagged union — the compiler tracks the active field
const Value = union(enum) {
    int: i64,
    float: f64,
    boolean: bool,
    none,

    pub fn show(self: Value) void {
        switch (self) {
            .int => |v| std.debug.print("int: {d}\n", .{v}),
            .float => |v| std.debug.print("float: {d}\n", .{v}),
            .boolean => |v| std.debug.print("bool: {}\n", .{v}),
            .none => std.debug.print("none\n", .{}),
        }
    }
};

pub fn main() void {
    var v: Value = .{ .int = 42 };
    v.show();
    v = .{ .float = 3.14 };
    v.show();
    v = .none;
    v.show();

    // Bare union — silence unused warning
    const fi: FloatOrInt = .{ .int = 7 };
    std.debug.print("bare: {d}\n", .{fi.int});
}
