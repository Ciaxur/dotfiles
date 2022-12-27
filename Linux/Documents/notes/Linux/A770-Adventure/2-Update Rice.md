# 🍚 Updating Environment
After the shear pain of Xorg, and anticipation of RDNA3 (*getting an 7900XTX soon*), I've decided
to upgrade my Display Server from `X11 -> Wayland` and WM/Compositor from `i3/picom -> Hyprland`.

# Requirements
- Install & Configure Display Server -> [Wayland][1]
- Install & configure compatible DM -> [greetd][5]
  - Chose to not reconfigure sddm to differentiate new change
- Install tiling WM/Compositor -> [Hyprland][2]
- Make sure all is good in the neighborhood = i3 configs -> Hyprland

## SDDM - Configuration
Used the same SDDM configs I had and installed the latest sddm from the AUR through `sddm-git`.

## greetd - Configuration (FAIL)
**TLDR;** Couldn't get it configured to run Hyprland. Kept panicing.

There is a Wayland greeter, so using that to start of with a baseline: [wlgreet][6]
- Would be nice to use other greeters, and enable support for wayland: TODO: look into https://man.sr.ht/~kennylevinsen/greetd/#how-to-set-xdg_session_typewayland

## Hyprland - Configuration
Oh my!!! Now **THIS** is how you configure displays!
In `~/.config/hypr/hyprland.conf`:
```conf
# See https://wiki.hyprland.org/Configuring/Monitors
# DP-4, left monitor, unscaled(1), rotated.
monitor=DP-4,2560x1440,0x0,1
monitor=DP-4,transform,1

# DP-3, middle monitor, unscaled(1)
monitor=DP-3,2560x1440@144,1440x658,1

# DP-2, right monitor, unscaled(1)
monitor=DP-2,2560x1440,4000x658,1
```

Gotchas:
- https://wiki.hyprland.org/Useful-Utilities/Hyprland-desktop-portal/

Alternatives:
- xdotool -> https://github.com/atx/wtype
- flameshot -> https://git.sr.ht/~whynothugo/shotman
- Polybar -> https://github.com/Alexays/Waybar

# Resources
- [Wayland - Arch Wiki][1]
- [Sway - Arch Wiki][4]
- [Hyprland][2]
- [Hyprland - Wiki][2-wiki]
- [Hyprland - Github][2-git]
- [feelsunbreeze Hyprland - Dotfiles][3]
- [feelsunbreeze Hyprland - Reddit][3-reddit]
- [Are We Wayland Yet][7]

[1]: https://wiki.archlinux.org/title/Wayland
[2]: https://hyprland.org/
[2-wiki]: https://wiki.hyprland.org/
[2-git]: https://github.com/hyprwm/Hyprland
[3]: https://github.com/feelsunbreeze/.dotfiles/
[3-reddit]: https://www.reddit.com/r/unixporn/comments/zu2jlq/hyprland_lysergic_malfunction/
[4]: https://wiki.archlinux.org/title/Sway
[5]: https://wiki.archlinux.org/title/Greetd
[6]: https://git.sr.ht/~kennylevinsen/wlgreet
[7]: https://arewewaylandyet.com/
