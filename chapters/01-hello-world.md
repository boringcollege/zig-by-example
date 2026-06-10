# Hello, World

Every Zig program starts at `pub fn main`.

```zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, World!\n", .{});
}
```

`@import` is a built-in that pulls in a module — `std` here is the standard
library. `std.debug.print` writes to stderr, which is handy because it needs
no buffer and no Io instance. For stdout you'll wire up a `Writer` (see
[chapter 32](32-formatting-and-print.md)).

```
$ zig run examples/01-hello-world.zig
Hello, World!
```

Source: [examples/01-hello-world.zig](../examples/01-hello-world.zig)

---
[Index](../README.md) | [Next →](02-values.md)
