const std = @import("std");

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const gpa = dbg.allocator();

    var io_impl: std.Io.Threaded = .init(gpa, .{});
    defer io_impl.deinit();
    const io = io_impl.io();

    // std.process.run is the convenience: spawn, wait, collect stdout/stderr.
    const result = try std.process.run(gpa, io, .{
        .argv = &.{ "uname", "-s" },
    });
    defer gpa.free(result.stdout);
    defer gpa.free(result.stderr);

    std.debug.print("os: {s}", .{result.stdout});
    std.debug.print("exit: {}\n", .{result.term});

    // Environment variables — libc getenv is the simplest lookup.
    if (std.c.getenv("PATH")) |val| {
        std.debug.print("PATH length: {d}\n", .{std.mem.span(val).len});
    }

    // Spawn a child you want to interact with, instead of just collecting output.
    var child = try std.process.spawn(io, .{
        .argv = &.{ "echo", "from spawn" },
        .stdin = .ignore,
        .stdout = .pipe,
        .stderr = .ignore,
    });

    var buf: [128]u8 = undefined;
    var fr = child.stdout.?.reader(io, &buf);
    const r = &fr.interface;
    if (try r.takeDelimiter('\n')) |line| {
        std.debug.print("child said: {s}\n", .{line});
    }
    _ = try child.wait(io);
}
