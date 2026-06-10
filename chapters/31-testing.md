# Testing

Testing is first-class in Zig — you write `test` blocks right alongside your
code, no separate framework needed.

```zig
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
```

```
$ zig test examples/31-testing.zig
All 4 tests passed.
```

`testing.allocator` checks for leaks at the end of each test, so a forgotten
`deinit` will fail the test instead of silently leaking memory.