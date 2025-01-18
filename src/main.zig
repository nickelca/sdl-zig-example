const screen_width = 800;
const screen_height = 600;

pub fn main() !void {
    if (c.SDL_Init(c.SDL_INIT_VIDEO) < 0) return error.SDL_Init;
    defer c.SDL_Quit();

    const window = c.SDL_CreateWindow(
        "Meow",
        c.SDL_WINDOWPOS_UNDEFINED_MASK | 0,
        c.SDL_WINDOWPOS_UNDEFINED_MASK | 0,
        screen_width,
        screen_height,
        c.SDL_WINDOW_SHOWN,
    ) orelse return error.SDL_CreateWindow;
    defer c.SDL_DestroyWindow(window);

    const renderer = c.SDL_CreateRenderer(window, -1, c.SDL_RENDERER_ACCELERATED) orelse return error.CreateRenderer;
    defer c.SDL_DestroyRenderer(renderer);

    var run = true;
    while (run) {
        var e: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&e) != 0) {
            if (e.type == c.SDL_QUIT) {
                run = false;
            }
        }

        _ = c.SDL_SetRenderDrawColor(renderer, 0xFF, 0xFF, 0xFF, 0xFF);
        _ = c.SDL_RenderClear(renderer);
        _ = c.SDL_RenderPresent(renderer);
    }
}

const c = @import("c");
