# Default to (primary) SD
if test -z "$rootpart"; then
  setenv rootpart 2
  saveenv
fi

if test -z "$altbootcmd"; then
  setenv altbootcmd 'echo Rollback upgrade
    if test ${rootpart} = 2; then setenv rootpart 3; else setenv rootpart 2; fi
    setenv upgrade_available 0; setenv bootcount 0; saveenv
    boot'
  saveenv
fi

setenv bootargs console=${console} console=tty1 root=/dev/mmcblk0p${rootpart} rootwait panic=10 ${extra}
setenv overlays cubieboard-ng-i2csens-overlay.dtbo cubieboard-ng-spisens-overlay.dtbo

# Load device tree and overlay
load mmc 0:${rootpart} ${fdt_addr_r} boot/${fdtfile}
fdt addr ${fdt_addr_r}
fdt resize
for overlay in ${overlays}; do
	load mmc 0:${rootpart} ${fdtoverlay_addr_r} boot/${overlay}
	fdt apply ${fdtoverlay_addr_r}
done

# Load kernel and boot
load mmc 0:${rootpart} ${kernel_addr_r} boot/uImage
bootm ${kernel_addr_r} - ${fdt_addr_r}
