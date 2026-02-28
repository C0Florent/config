local waywall = require("waywall")
local helpers = require("waywall.helpers")
local nix = require("nix") -- import constants from my nix config

local function mapAttrs(table, f)
    local ret = {};
    for k,v in pairs(f) do
        ret[k] = f(k,v);
    end
    return ret;
end

local is_process_running = function(pname)
    local handle = io.popen("pgrep -f '" .. pname .. "'");
    local result = handle:read("*l");
    handle:close();
    return result ~= nil;
end

local config = {
    input = {
        layout = nix.input.kb_layout,
        repeat_rate = nix.input.repeat_rate,
        repeat_delay = nix.input.repeat_delay,

        sensitivity = 7.86080037,
        confine_pointer = false,
        remaps = {
            ["MB5"] = "F3",
        }
    },
    theme = {
        background_png = nix.background,
    },
    actions = {},
}

local resolutions = {
    thin = { key = "CTRL-Alt_L", w = 340, h = 1080 },
    tall = { key = "CTRL-w", w = 384, h = 16384, sens = 0.53028489 },
    wide = { key = "*-v", w = 1920, h = 340, ingame = true },
};

local mirrors = {
    eye_measure = helpers.res_mirror({
        src = { x = 177, y = 7902, w = 30, h = 580 },
        dst = { x = 0, y = 370, w = 790, h = 340 },
    }, resolutions.tall.w, resolutions.tall.h);
};

local eye_img = helpers.res_image(
    nix.eye_overlay,
    { dst = {
        x = 0,
        y = 370,
        w = 790,
        h = 340,
    }},
    resolutions.tall.w,
    resolutions.tall.h
);

for k, v in pairs(resolutions) do
    if v.ingame then
        config.actions[v.key] = helpers.ingame_only(helpers.toggle_res(v.w, v.h, v.sens));
    else
        config.actions[v.key] = helpers.toggle_res(v.w, v.h, v.sens);
    end
end

config.actions["*-x"] = function()
    if is_process_running("Ninjabrain.*jar") then
        helpers.toggle_floating();
    else
        waywall.exec(nix.nbb);
        waywall.show_floating(true);
    end
end;

return config

