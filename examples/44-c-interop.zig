const std = @import("std");
const c = @cImport({
    @cInclude("math.h");
    @cInclude("stdio.h");
});

// Exporting a Zig function with C ABI
export fn add(a: c_int, b: c_int) c_int {
    return a + b;
}

pub fn main() void {
    // Calling C math.h
    const result = c.sqrt(2.0);
    std.debug.print("C sqrt(2) = {d:.6}\n", .{result});

    // Calling C printf — the variadic call needs an explicit cast for the int arg
    _ = c.printf("Hello from C: %d\n", @as(c_int, 42));

    // Our exported function is just a normal Zig function locally
    std.debug.print("add(2, 3) = {d}\n", .{add(2, 3)});
}
