# Errors

In Zig, errors are values rather than exceptions. An error union type is written `ErrorSet!T`.

```zig
const std = @import("std");

// Define an error set
const ParseError = error{
    InvalidCharacter,
    Overflow,
    Empty,
};

fn parsePositive(s: []const u8) ParseError!u32 {
    if (s.len == 0) return ParseError.Empty;
    var result: u32 = 0;
    for (s) |c| {
        if (c < '0' or c > '9') return ParseError.InvalidCharacter;
        result = result * 10 + (c - '0');
    }
    return result;
}

pub fn main() void {
    // catch — handle or transform the error
    const n = parsePositive("123") catch |err| {
        std.debug.print("error: {}\n", .{err});
        return;
    };
    std.debug.print("parsed: {d}\n", .{n});

    // catch with a default value
    const m = parsePositive("abc") catch 0;
    std.debug.print("default: {d}\n", .{m});

    // if/else unwrap, then switch on the error set
    if (parsePositive("")) |v| {
        std.debug.print("ok: {d}\n", .{v});
    } else |err| switch (err) {
        error.Empty => std.debug.print("empty input\n", .{}),
        error.InvalidCharacter => std.debug.print("bad char\n", .{}),
        error.Overflow => std.debug.print("overflow\n", .{}),
    }
}
```

Inside a function that itself returns an error union, you can `try foo()` —
that bubbles the error up right away. Reach for `catch` when you want to handle it.

Source: [examples/20-errors.zig](../examples/20-errors.zig)

---
[← Previous](19-defer.md) | [Index](../README.md) | [Next →](21-optionals.md)
