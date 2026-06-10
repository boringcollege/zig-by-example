# Build System

Zig's build system is written in Zig itself. A `build.zig` at the project
root describes how things get built. From 0.15 onward, executables and tests
are built from a `root_module` rather than a `root_source_file` field.

```zig
// build.zig
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // 0.15+ : an executable is built from a root_module, not root_source_file.
    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "myapp",
        .root_module = exe_mod,
    });
    b.installArtifact(exe);

    // Run step: `zig build run`
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_cmd.step);

    // Test step: `zig build test`
    const tests_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    const unit_tests = b.addTest(.{ .root_module = tests_mod });
    const run_tests = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_tests.step);
}
```

```
$ zig build                         # builds to zig-out/bin/myapp
$ zig build run                     # builds and runs
$ zig build test                    # builds and runs tests
$ zig build -Doptimize=ReleaseFast  # release build
```

Cross-compile to any supported target — no separate toolchain required:

```
$ zig build -Dtarget=aarch64-linux
$ zig build -Dtarget=x86_64-windows
$ zig build -Dtarget=wasm32-freestanding
```