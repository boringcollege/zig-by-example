const std = @import("std");

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const gpa = dbg.allocator();

    // std.Io.Threaded is the default Io implementation — it backs each
    // concurrent unit of work with a real OS thread. An evented backend
    // (epoll / kqueue / io_uring) is also available on supported platforms.
    var io_impl: std.Io.Threaded = .init(gpa, .{});
    defer io_impl.deinit();

    // The `Io` value is a small fat-pointer (userdata + vtable). Pass it
    // to every function that touches the OS: file I/O, networking,
    // processes, sync primitives, sleeping, and entropy.
    const io: std.Io = io_impl.io();

    // Sleep is dispatched through Io rather than the syscall directly,
    // so an evented Io can suspend the fiber instead of blocking a thread.
    std.debug.print("sleeping 50ms...\n", .{});
    try io.sleep(.fromMilliseconds(50), .awake);

    // Entropy: io.random fills a buffer with cryptographically secure bytes.
    var seed: u64 = undefined;
    io.random(std.mem.asBytes(&seed));
    std.debug.print("seed: {d}\n", .{seed});

    // Now anything that needs Io can use the same value. Here we
    // create a child process — see 37-processes for more.
    const r = try std.process.run(gpa, io, .{ .argv = &.{ "echo", "Io is wired up" } });
    defer gpa.free(r.stdout);
    defer gpa.free(r.stderr);
    std.debug.print("{s}", .{r.stdout});
}
