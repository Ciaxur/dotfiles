-- Hyprland config file.
-- See https://wiki.hyprland.org/ for more info.

-- ###################### CUSTOM VARIABLES ###########################
-- https://wiki.hyprland.org/Configuring/Keywords/#defining-variables
-- ###################################################################
local PRIMARY_COLOR                       = "rgba(33CCFFEE)"
local PRIMARY_INACTIVE_COLOR              = "rgba(595959AA)"
local PRIMARY_GRADIANT_COLOR              = { colors = { PRIMARY_COLOR, "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 }
local PRIMARY_FONT_COLOR                  = "rgb(FFFFFF)"
local PRIMARY_GROUP_COLOR                 = "rgba(BCEEFF66)"
local PRIMARY_GROUP_INACTIVE_COLOR        = "rgba(004D7759)"
local PRIMARY_GROUP_LOCKED_ACTIVE_COLOR   = "rgba(ff550066)"
local PRIMARY_GROUP_LOCKED_INACTIVE_COLOR = "rgba(ff550055)"
local PRIMARY_FONT_FAMILY                 = "SF Pro Display Semibold"

-- ###################### ENVIRONMENT VARIABLES ###########################
-- https://wiki.hyprland.org/Configuring/Environment-variables
-- ########################################################################
-- https://wiki.hyprland.org/Hypr-Ecosystem/hyprcursor
-- HiDPI Adwaita cursor: https://github.com/drepper/adwaita-cursors
hl.env("HYPRCURSOR_THEME", "Adwaita-hidpi")
hl.env("HYPRCURSOR_SIZE", "16")

-- ############ MONITOR CONFIGURATION ################
-- See https://wiki.hyprland.org/Configuring/Monitors/
--
-- xrandr equivelant: `wlr-randr`
-- https://github.com/emersion/wlr-randr
-- ###################################################
-- Left monitor, unscaled(1), rotated.
hl.monitor({
    output    = "DP-2",
    mode      = "2560x1440@144",
    position  = "0x-325",
    scale     = 1,
    transform = 1,
    bitdepth  = 10,
})

-- Middle monitor, unscaled(1)
hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@240",
    position = "1440x730",
    scale    = 1,
    bitdepth = 10,
    -- cm = "hdr", sdrbrightness = 1.4,
})

-- Right monitor, unscaled(1)
hl.monitor({
    output   = "DP-3",
    mode     = "2560x1440@74.976997",
    position = "4000x730",
    scale    = 1,
    bitdepth = 10,
})

-- ########################## VARIABLES ###############################
-- See https://wiki.hypr.land/Configuring/Basics/Variables for more
-- ####################################################################

-- ######################### CURSOR CONFIG ############################
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#cursor
-- ####################################################################
hl.config({
    cursor = {
        -- sync xcursor theme with gsettings, it applies cursor-theme and cursor-size
        -- on theme load to gsettings making most CSD gtk based clients use same
        -- xcursor theme and size.
        sync_gsettings_theme = true,
    },
})

-- ######################### INPUT CONFIG #############################
-- See https://wiki.hyprland.org/Configuring/Variables/
-- ####################################################################
hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        -- The repeat rate for held-down keys, in repeats per second.
        repeat_rate = 50,
        -- Delay before a held-down key is repeated, in milliseconds.
        repeat_delay = 250,
        touchpad = {
            natural_scroll = false,
        },
        sensitivity = 0,
        -- -1.0 - 1.0, 0 means no modification.
    },
})

-- ######################## GENERAL CONFIG ############################
-- See https://wiki.hyprland.org/Configuring/Variables/ for more
-- ####################################################################
hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 1,
        border_size = 2,
        layout = "dwindle",
        col = {
            active_border = PRIMARY_GRADIANT_COLOR,
            inactive_border = PRIMARY_INACTIVE_COLOR,
        },
    },
})

-- ##################### DECORATION/ANIMATION #########################
-- Under https://wiki.hyprland.org/Configuring/Variables
--
-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
-- See https://wiki.hyprland.org/Configuring/Animations/ for more
-- See https://wiki.hyprland.org/Configuring/Variables/#blur for more
-- ####################################################################
hl.config({
    decoration = {
        rounding         = 5,
        active_opacity   = 1,
        inactive_opacity = 0.95,
        blur = {
            enabled           = true,
            size              = 5,
            passes            = 1,
            new_optimizations = true,
        },
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
    },
})

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve( "myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.animation({ leaf = "windows", enabled = true, speed = 2.0, bezier = "myBezier" })

-- Window Open/Close
hl.animation({ leaf = "windowsIn", enabled = true, speed = 1.0, bezier = "default", style = "popin 50%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.0, bezier = "default", style = "popin 50%" })

hl.animation({ leaf = "border", enabled = true, speed = 10.0, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7.0, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.0, bezier = "default", style = "fade" })


hl.config({
    dwindle = {
        preserve_split = true,
        -- you probably want this
        -- Alows a more precise control over the window split
        -- direction based on the cursor's position.
        -- The window is conceptually divided into four triangles,
        -- and cursor's triangle determines the split direction.
        -- This feature also turns on preserve_split.
        smart_split = false,
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#group
hl.config({
    group = {
        -- https://wiki.hyprland.org/Configuring/Variables/#groupbar
        groupbar = {
            col = {
                active          = PRIMARY_GROUP_COLOR,
                inactive        = PRIMARY_GROUP_INACTIVE_COLOR,
                locked_active   = PRIMARY_GROUP_LOCKED_ACTIVE_COLOR,
                locked_inactive = PRIMARY_GROUP_LOCKED_INACTIVE_COLOR,
            },

            enabled       = true,
            font_family   = PRIMARY_FONT_FAMILY,
            font_size     = 8,
            gradients     = true,
            priority      = 3,
            render_titles = true,
            scrolling     = true,
            text_color    = "rgba(C7FFEDFF)",
            height        = 6,
        },

        col = {
            border_active          = PRIMARY_GRADIANT_COLOR,
            border_inactive        = PRIMARY_GROUP_INACTIVE_COLOR,
            border_locked_active   = PRIMARY_GROUP_LOCKED_ACTIVE_COLOR,
            border_locked_inactive = PRIMARY_GROUP_LOCKED_INACTIVE_COLOR,
        },
    },
})

-- ######################### LAYOUT CONFIG ############################
-- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
-- ####################################################################

-- ######################### STARTUP APPS #############################
-- ####################################################################
-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("swww-daemon")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("keychain")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE")
end)

-- Exec (run at startup AND every reload)
local function exec_reload()
    hl.exec_cmd("~/.config/hypr/scripts/set_random_wallpaper.sh")
    hl.exec_cmd("~/.config/dunst/reload.sh")
    hl.exec_cmd("~/.config/hypr/scripts/waybar.sh")
end
hl.on("hyprland.start", exec_reload)
hl.on("config.reloaded", exec_reload)

-- ######################### GLOBAL RULES #############################
-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
-- ####################################################################
hl.window_rule({
    name  = "ueberzugpp-image-preview-window-floats",
    match = {
        initial_class = "ueberzugpp.*",
    },
    float = true,
    no_initial_focus = true,
})

hl.window_rule({
    name  = "file-selection-floats",
    match = {
        initial_class = "xdg-desktop-portal-gtk",
    },
    float = true,
})

hl.window_rule({
    name  = "no-name-no-blur",
    match = {
        class = "^()$",
        title = "^()$",
    },
    no_blur = true,
})

-- Picture in picture always shown
hl.window_rule({
    name  = "picture-in-picture-auto-pin",
    match = {
        initial_title = "(Picture in picture|Discord Popout)",
    },
    pin = true,
    float = true,
})

-- XWayland Video Bridge
-- http://wiki.hyprland.org/Useful-Utilities/Screen-Sharing/#xwayland
hl.window_rule({
    name  = "xwayland-video-bridge-fixes",
    match = {
        class = "xwaylandvideobridge",
    },
    no_initial_focus = true,
    no_focus = true,
    no_anim = true,
    no_blur = true,
    max_size = { 1, 1 },
    opacity = 0.0,
})

-- ######################## SUBMAP - RESIZE ###########################
-- See https://wiki.hyprland.org/Configuring/Binds/#submaps for more
-- ####################################################################

hl.bind("SUPER + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    -- Slow resize (repeat when held).
    hl.bind("right", hl.dsp.window.resize({ x = 5,  y = 0,  relative = true }), { repeating = true })
    hl.bind("left",  hl.dsp.window.resize({ x = -5, y = 0,  relative = true }), { repeating = true })
    hl.bind("up",    hl.dsp.window.resize({ x = 0,  y = -5, relative = true }), { repeating = true })
    hl.bind("down",  hl.dsp.window.resize({ x = 0,  y = 5,  relative = true }), { repeating = true })

    -- Fast resize.
    hl.bind("SHIFT + right", hl.dsp.window.resize({ x = 15,  y = 0,   relative = true }), { repeating = true })
    hl.bind("SHIFT + left",  hl.dsp.window.resize({ x = -15, y = 0,   relative = true }), { repeating = true })
    hl.bind("SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -15, relative = true }), { repeating = true })
    hl.bind("SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 15,  relative = true }), { repeating = true })

    -- SUPA resize.
    hl.bind("SHIFT + CTRL + right", hl.dsp.window.resize({ x = 100,  y = 0,    relative = true }), { repeating = true })
    hl.bind("SHIFT + CTRL + left",  hl.dsp.window.resize({ x = -100, y = 0,    relative = true }), { repeating = true })
    hl.bind("SHIFT + CTRL + up",    hl.dsp.window.resize({ x = 0,    y = -100, relative = true }), { repeating = true })
    hl.bind("SHIFT + CTRL + down",  hl.dsp.window.resize({ x = 0,    y = 100,  relative = true }), { repeating = true })

    -- Resize to a Specific Dimension.
    -- Omitting `relative` means an ABSOLUTE resize, i.e. the `setactivesize`
    -- that set_active_window_size.sh used to emulate (read size, subtract,
    -- dispatch a relative resize). Upstream lua does it directly, so the
    -- script is gone.
    hl.bind("0", hl.dsp.window.resize({ x = 560,  y = 360 }))
    hl.bind("1", hl.dsp.window.resize({ x = 720,  y = 480 }))
    hl.bind("2", hl.dsp.window.resize({ x = 800,  y = 600 }))
    hl.bind("3", hl.dsp.window.resize({ x = 1060, y = 800 }))
    hl.bind("4", hl.dsp.window.resize({ x = 640,  y = 800 }))
    hl.bind("5", hl.dsp.window.resize({ x = 720,  y = 900 }))
    hl.bind("6", hl.dsp.window.resize({ x = 720,  y = 1000 }))

    -- NOTE: Reset submaps back to global.
    -- use reset to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))
    -- will reset the submap, meaning end the current one and return to the global one
end)


-- ################### BINDINGS & WINDOW RULES ########################
-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
-- See https://wiki.hyprland.org/Configuring/Keywords/ for more
-- See https://wiki.hyprland.org/Configuring/Binds/ for more
--
-- Can use hyprprop-git(AUR) as an xprop equivelant.
-- Can get keycodes by running `xev`.
-- Can print inputs using `sudo libinput debug-events`.
-- ####################################################################

-- App spawning.
hl.bind("SUPER + return", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + C",      hl.dsp.exec_cmd("thorium-browser"))
hl.bind("SUPER + Q",      hl.dsp.window.close())
hl.bind("SUPER + N",      hl.dsp.exec_cmd("nautilus -w"))

-- Misc.
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("~/.config/hypr/scripts/set_random_wallpaper.sh"))
hl.bind("SUPER + period",    hl.dsp.exec_cmd("~/scripts/dmenu-emoji/dmenu-emoji.sh"))
hl.bind("SUPER + space",     hl.dsp.exec_cmd("~/scripts/dmenu-apps/dmenu-app.sh"))

hl.bind("SUPER + CTRL + SHIFT + R", hl.dsp.force_renderer_reload())

-- Dunst keybindings.
hl.bind("CTRL + ALT + space",    hl.dsp.exec_cmd("dunstctl close"))
hl.bind("CTRL + SHIFT + space",  hl.dsp.exec_cmd("dunstctl close-all"))
hl.bind("SUPER + CTRL + space",  hl.dsp.exec_cmd("dunstctl history-pop"))
hl.bind("SUPER + CTRL + period", hl.dsp.exec_cmd("dunstctl context"))

-- Media player controls

-- Spotify High Priority
hl.bind("SUPER + P", hl.dsp.exec_cmd("playerctl play-pause -p spotify || exec playerctl play-pause"))
hl.bind("SUPER + F12", hl.dsp.exec_cmd("playerctl next -p spotify || exec playerctl next"))
hl.bind("SUPER + F11", hl.dsp.exec_cmd("playerctl previous -p spotify || exec playerctl previous"))

-- MOD+PRINT_SCRN = Screenshot.
hl.bind("SUPER + code:107", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh -c | tee -a /tmp/screenshot-hyprland.log"))
hl.bind("SUPER + SHIFT + code:107", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh -d -c | tee -a /tmp/screenshot-hyprland.log"))

-- Window toggles/dispatchers.
-- https://wiki.hyprland.org/Configuring/Dispatchers/#list-of-dispatchers
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + space", hl.dsp.window.float())

-- Toggle Waybar (idea is a mini-fullscreen mode)
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_waybar.sh"))

-- dwindle configuration: https://wiki.hyprland.org/Configuring/Dwindle-Layout/.
-- Toggle splitting horizontal/vertical.
hl.bind("SUPER + V", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + W", hl.dsp.group.toggle())

-- Explicitly change window focus, which allows moving focus even when a window
-- in focus is grouped.
hl.bind("SUPER + ALT + left",  hl.dsp.focus({ direction="left" }))
hl.bind("SUPER + ALT + right", hl.dsp.focus({ direction="right" }))
hl.bind("SUPER + ALT + up",    hl.dsp.focus({ direction="up" }))
hl.bind("SUPER + ALT + down",  hl.dsp.focus({ direction="down" }))

-- Move window position based on floating/tiled mode.
-- NOTE: `relative = true` is required, it defaults to false (absolute move).
hl.bind("SUPER + SHIFT + left",  hl.dsp.window.move({ x = -50,  y = 0,   relative = true }))
hl.bind("SUPER + SHIFT + down",  hl.dsp.window.move({ x = 0,    y = 50,  relative = true }))
hl.bind("SUPER + SHIFT + up",    hl.dsp.window.move({ x = 0,    y = -50, relative = true }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ x = 50,   y = 0,   relative = true }))

-- Move floating window at a larger offset.
hl.bind("SUPER + CTRL + SHIFT + left",  hl.dsp.window.move({ x = -200, y = 0,    relative = true }))
hl.bind("SUPER + CTRL + SHIFT + down",  hl.dsp.window.move({ x = 0,    y = 200,  relative = true }))
hl.bind("SUPER + CTRL + SHIFT + up",    hl.dsp.window.move({ x = 0,    y = -200, relative = true }))
hl.bind("SUPER + CTRL + SHIFT + right", hl.dsp.window.move({ x = 200,  y = 0,    relative = true }))

-- Move window focus.
-- Was tab_between_windows.sh, which shelled out to `hyprctl activewindow | rg`
-- plus a `hyprctl dispatch` per keypress. `hl.dsp` is not a shell dispatcher
-- anymore (it evaluates lua), so that script broke; this does the same thing
-- natively via HL.Window.group, with no subprocess.
--
-- Grouped  -> left/right tab within the group, up/down do nothing (as before).
-- Ungrouped-> move focus in the given direction.
local function tab_between_windows(dir)
    return function()
        local w = hl.get_active_window()
        if w and w.group then
            if dir == "l" then
                hl.dispatch(hl.dsp.group.prev())
            elseif dir == "r" then
                hl.dispatch(hl.dsp.group.next())
            end
            return
        end
        hl.dispatch(hl.dsp.focus({ direction = dir }))
    end
end

hl.bind("SUPER + left",  tab_between_windows("l"))
hl.bind("SUPER + right", tab_between_windows("r"))
hl.bind("SUPER + up",    tab_between_windows("u"))
hl.bind("SUPER + down",  tab_between_windows("d"))

-- Switch workspaces with MOD + [0-9]
-- Move active window to a workspace without switching to the workspace
-- (`follow = false` must live in the SAME table as `workspace`).
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Move/resize windows with MOD + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Pipewire Audio Controls.
hl.bind("code:123", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +1%"), { repeating = true })  -- Increase Active Output Device
hl.bind("code:122", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -1%"), { repeating = true })  -- Decrease Active Output Device
hl.bind("code:121", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))                       -- Mute Active Output Device

-- Zoom
-- Native lua instead of `hyprctl keyword` + jq: `keyword` is gone from the
-- lua-era docs, and option paths are now dot-separated (cursor.zoom_factor).
-- Pure lua also keeps the bind callback non-blocking, as the wiki requires.
local function zoom(mult)
    return function()
        local cur = hl.get_config("cursor.zoom_factor") or 1
        hl.config({ cursor = { zoom_factor = math.max(1, cur * mult) } })
    end
end
hl.bind("SUPER + SHIFT + mouse_down", zoom(1.2))
hl.bind("SUPER + SHIFT + mouse_up",   zoom(0.8))
hl.bind("SUPER + SHIFT + CTRL + 0",   function() hl.config({ cursor = { zoom_factor = 1 } }) end)
