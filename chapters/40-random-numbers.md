# Random Numbers

In 0.16, OS entropy flows through `io.random(buf)`. For non-cryptographic
random numbers, you seed a fast PRNG with that entropy and use it from there.

```zig
const std = @import("std");

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const gpa = dbg.allocator();

    var io_impl: std.Io.Threaded = .init(gpa, .{});
    defer io_impl.deinit();
    const io = io_impl.io();

    // io.random fills bytes with cryptographically secure entropy from the OS.
    var seed: u64 = undefined;
    io.random(std.mem.asBytes(&seed));

    // Cheap, fast, non-cryptographic PRNG, seeded from real entropy.
    var prng: std.Random.DefaultPrng = .init(seed);
    const rand = prng.random();

    // Random integer in [1, 100]
    const n = rand.intRangeAtMost(u32, 1, 100);
    std.debug.print("dice: {d}\n", .{n});

    // Random float in [0.0, 1.0)
    const f = rand.float(f64);
    std.debug.print("float: {d:.4}\n", .{f});

    // Shuffle in place
    var arr = [_]u8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    rand.shuffle(u8, &arr);
    std.debug.print("shuffled: {any}\n", .{arr});

    // Random boolean
    std.debug.print("coin: {}\n", .{rand.boolean()});
}
```

Reach for `io.random` directly when you need cryptographic randomness —
say, generating session tokens. For everything else, `std.Random.DefaultPrng`
(Xoshiro256) is the right pick.

Source: [examples/40-random-numbers.zig](../examples/40-random-numbers.zig)

---
[← Previous](39-json.md) | [Index](../README.md) | [Next →](41-sorting.md)
