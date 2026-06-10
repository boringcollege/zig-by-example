# Networking & HTTP

Sockets live under `std.Io.net`, and HTTP is in `std.http`. Both share the
same `Io` value, so they can run on a `Threaded` or `Evented` backend with
no source-level changes.

```zig
const std = @import("std");

const port: u16 = 18080;

fn serverThread(io: std.Io, ready: *std.Io.Mutex) !void {
    const addr: std.Io.net.IpAddress = .{ .ip4 = .loopback(port) };
    var server = try addr.listen(io, .{ .reuse_address = true });
    defer server.deinit(io);

    ready.unlock(io); // signal: now accepting

    var stream = try server.accept(io);
    defer stream.close(io);

    var read_buf: [128]u8 = undefined;
    var write_buf: [128]u8 = undefined;
    var rr = stream.reader(io, &read_buf);
    var ww = stream.writer(io, &write_buf);

    const line = (try rr.interface.takeDelimiter('\n')) orelse return;
    try ww.interface.writeAll("echo: ");
    try ww.interface.writeAll(line);
    try ww.interface.writeAll("\n");
    try ww.interface.flush();
}

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const gpa = dbg.allocator();

    var io_impl: std.Io.Threaded = .init(gpa, .{});
    defer io_impl.deinit();
    const io = io_impl.io();

    // --- TCP: tiny echo server on a background thread, client on the main thread ---
    var ready: std.Io.Mutex = .init;
    ready.lock(io) catch unreachable; // held until server is listening
    const t = try std.Thread.spawn(.{}, serverThread, .{ io, &ready });

    // Wait for the server to be ready
    ready.lock(io) catch unreachable;
    ready.unlock(io);

    const addr: std.Io.net.IpAddress = .{ .ip4 = .loopback(port) };
    var stream = try addr.connect(io, .{ .mode = .stream });
    defer stream.close(io);

    var read_buf: [128]u8 = undefined;
    var write_buf: [128]u8 = undefined;
    var rr = stream.reader(io, &read_buf);
    var ww = stream.writer(io, &write_buf);

    try ww.interface.writeAll("ping\n");
    try ww.interface.flush();

    if (try rr.interface.takeDelimiter('\n')) |line| {
        std.debug.print("server said: {s}\n", .{line});
    }
    t.join();

    // --- HTTP client: one-shot fetch ---
    var client: std.http.Client = .{ .allocator = gpa, .io = io };
    defer client.deinit();

    var body: std.Io.Writer.Allocating = .init(gpa);
    defer body.deinit();

    const res = try client.fetch(.{
        .location = .{ .url = "http://example.com/" },
        .response_writer = &body.writer,
    });
    std.debug.print("status: {d}, body bytes: {d}\n", .{ @intFromEnum(res.status), body.written().len });
}
```

Address construction uses concise decl literals:

```zig
const v4: std.Io.net.IpAddress = .{ .ip4 = .loopback(8080) };
const v4_any: std.Io.net.IpAddress = .{ .ip4 = .unspecified(0) };
const parsed = try std.Io.net.IpAddress.parse("127.0.0.1", 80);
```

For richer HTTP (streamed bodies, custom headers, redirects), use
`client.request(method, uri, opts)` and drive the `Request` yourself.