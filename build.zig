pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    const exe = b.addExecutable(.{
        .name = "sdl-example",
        .root_module = exe_mod,
    });

    const sdl_dep = b.dependency("SDL", .{
        .target = target,
        .optimize = optimize,
    });
    const sdl_lib = sdl_dep.artifact("SDL2");
    exe.linkLibrary(sdl_lib);

    const c = b.addTranslateC(.{
        .root_source_file = b.path("src/include.h"),
        .target = target,
        .optimize = optimize,
    });
    c.addIncludePath(sdl_lib.getEmittedIncludeTree());
    exe.root_module.addImport("c", c.createModule());

    b.installArtifact(exe);
}

const std = @import("std");
