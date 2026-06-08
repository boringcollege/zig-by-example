const std = @import("std");

const Point = struct {
    x: f32,
    y: f32,

    pub fn distanceToOrigin(self: Point) f32 {
        return std.math.sqrt(self.x * self.x + self.y * self.y);
    }
};

const Rectangle = struct {
    origin: Point,
    width: f32,
    height: f32,

    pub fn area(self: Rectangle) f32 {
        return self.width * self.height;
    }
};

pub fn main() void {
    const p: Point = .{ .x = 3.0, .y = 4.0 };
    std.debug.print("dist: {d}\n", .{p.distanceToOrigin()}); // 5

    const r: Rectangle = .{
        .origin = .{ .x = 0, .y = 0 },
        .width = 10,
        .height = 5,
    };
    std.debug.print("area: {d}\n", .{r.area()}); // 50

    // Default field values
    const Circle = struct {
        radius: f32 = 1.0,
    };
    const unit: Circle = .{};
    std.debug.print("radius: {d}\n", .{unit.radius});
}
