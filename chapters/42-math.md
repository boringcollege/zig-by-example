# Math

```zig
const std = @import("std");
const math = std.math;

pub fn main() void {
    // Constants
    std.debug.print("pi  = {d:.8}\n", .{math.pi});
    std.debug.print("e   = {d:.8}\n", .{math.e});
    std.debug.print("phi = {d:.8}\n", .{math.phi});

    // Common functions
    std.debug.print("abs(-5)       = {d}\n", .{@abs(@as(i32, -5))});
    std.debug.print("sqrt(144)     = {d}\n", .{math.sqrt(@as(f64, 144))});
    std.debug.print("pow(2, 10)    = {d}\n", .{math.pow(f64, 2, 10)});
    std.debug.print("log2(1024)    = {d:.1}\n", .{math.log2(@as(f64, 1024))});
    std.debug.print("floor(3.7)    = {d}\n", .{math.floor(@as(f64, 3.7))});
    std.debug.print("ceil(3.2)     = {d}\n", .{math.ceil(@as(f64, 3.2))});
    std.debug.print("sin(pi/2)     = {d:.4}\n", .{math.sin(math.pi / 2.0)});
    std.debug.print("cos(0)        = {d:.4}\n", .{math.cos(@as(f64, 0))});

    // Integer math
    std.debug.print("gcd(12,8)     = {d}\n", .{math.gcd(12, 8)}); // 4
    std.debug.print("clamp(15,0,10)= {d}\n", .{math.clamp(@as(i32, 15), 0, 10)}); // 10
    std.debug.print("maxInt(u8)    = {d}\n", .{math.maxInt(u8)}); // 255
    std.debug.print("minInt(i8)    = {d}\n", .{math.minInt(i8)}); // -128
}
```