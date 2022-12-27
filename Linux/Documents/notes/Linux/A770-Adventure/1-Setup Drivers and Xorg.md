# A770 Setup
The acclaimed `Kernel 6.0+ out of the box` experience for Intel's DG2 GPUs are not that accurate.
Yeh, the GPU works with the existing open souce Mesa drivers, though do not provide compat. with Xorg's
`Intel` drivers. Errors ranged from using `No Screens Found` to Xorg seg-faults.

Following [Intel Graphics - Arch Wiki][1] page for a basic guide.

## Kernel Module Early-KMS
As a nice to have, added the i915 Intel Kernel module to be loaded on startup by adding the following
to `/etc/mkinitcpio.conf`:
```ini
MODULES=(amdgpu radeon i915)
```

Can also use `modeprob` to add/remove the module. `modinfo i915`.

> To rebuild mkinitcpio, just reinstall the linux kernel `pacman -S linux`, which'll trigger the post-hook.

## Xorg Nightmare
Since Intel dGPU support is still in its infancy, there is no Xorg Configuration generator as with
what Nvidia's `nvidia-settings` provides, so all of this is manual ;(.

Intel display drivers do not work, yielding No screens found. Even the wikipage suggests using `modesetting`.
```conf
Section "Device"
  Identifier  "Device0"
  Driver      "modesetting"
  BusID       "PCI:7:0:0"

  Option      "DRI" "3"
  Option      "TearFree" "true"
  Option      "AccelMethod" "sna"
EndSection
```

Thankfully, the generated default Xorg configuration provides insight into what Driver options are supported
by the Intel drivers. To generate this configuration, run `Xorg -configure`, which'll spit out an xorg config
in the user's home directory.

> NOTE: This might not work with the default user, as they have no permissions to the X11 server.
> Also make sure X11 server is not running. For convenience, just switched to root.


# Resources
- [Intel Graphics - Arch Wiki][1]
- [Intel Arc November Review - Phoronix][2]

[1]: https://wiki.archlinux.org/title/Intel_graphics
[2]: https://www.phoronix.com/review/intel-arc-nov