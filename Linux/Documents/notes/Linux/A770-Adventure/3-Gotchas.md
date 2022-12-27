# X11 -> Wayland Gotchas
Tweaks after the migration!
NOTE: Use `extramaus` to find out if an application is running under XWayland.


## Applications running under XWayland
Chromium, Code, Spotify, Steam, and Discord ran under XWayland which caused resize glitches, dropped called, and sometimes crashes.
Not to mention, steam couldn't load Vulkan!


## Removing XWayland
Had to build hyprland manually with a custom flag: https://wiki.hyprland.org/Getting-Started/Installation/#custom-build-flags
to remove XWayland support.

This caused Electron based applications to not display.
Flags for electron-based apps:
```sh
<app executable> --enable-features=UseOzonePlatform --ozone-platform=wayland
```

Perminent Chromium fix:
```
Go to chrome://flags
Search "Preferred Ozone platform"
Set it to "Wayland"
Restart
```

Perminent VS Code fix, add to `~/.config/code-flags.conf`:
```
--enable-features=UseOzonePlatform
--ozone-platform=wayland
```/usr/lib/xdg-desktop-portal
```

Need to intall wayland's version of rofi 
- https://github.com/lbonn/rofi

Definitly need Wayland supported polkit and not lxpolkit. `polkit-kde-agent`.

Used wayland version of discord from the Aur: `discord_arch_electron_wayland`.
- Likewise with code above, set `~/.config/discord-flags.conf`.
- NOTE: This didn't work. Discord kept crashing...


### Steam 
The Steam client not launching due to X11. Currently, it's an X11 application :/.
**Reverting back to using xorg-Xwayland for backward support for Steam, Spoify & Discord.**


### Games failing to launch under Vulkan
TLDR; need `lib32-vulkan-intel` and `vulkan-intel` packages. I was missing the former.

Launching Cyberpunk 2077, while having steam open from the terminal to get logs. Got this error:
```
terminate called after throwing an instance of 'dxvk::DxvkError'
```



Set `SDL_VIDEODRIVEVER=wayland` for games. -> Within the 
- https://github.com/ValveSoftware/steam-for-linux/issues/8020


## Additional Nice to haves
Enabled the `WebRTC PipeWire support` flag in chromium.
