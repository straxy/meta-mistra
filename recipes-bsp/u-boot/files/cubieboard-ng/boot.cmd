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
load mmc 0:${rootpart} ${fdt_addr_r} boot/${fdtfile}
load mmc 0:${rootpart} ${kernel_addr_r} boot/uImage
bootm ${kernel_addr_r} - ${fdt_addr_r}
