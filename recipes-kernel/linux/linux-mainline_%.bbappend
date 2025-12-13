FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:cubieboard = "\
	file://axp20x.cfg \
	file://sound.cfg \
"

SRC_URI:append:mistra-recovery = "\
	file://initramfs.cfg \
"

SRC_URI:append:cubieboard-ng = "\
	file://sun4i-a10.dtsi-Update-for-custom-memory-mapped-device.patch \
	file://sun4i-cubieboard-Enable-UART1-in-DTS.patch \
	file://cubieboard-ng-i2csens-overlay.dtso;subdir=linux-${PV}/arch/arm/boot/dts/allwinner \
	file://cubieboard-ng-spidev-overlay.dtso;subdir=linux-${PV}/arch/arm/boot/dts/allwinner \
	file://cubieboard-ng-spisens-overlay.dtso;subdir=linux-${PV}/arch/arm/boot/dts/allwinner \
"

KERNEL_DTC_FLAGS += "-@"

KERNEL_DEVICETREE:append = "\
	allwinner/cubieboard-ng-i2csens-overlay.dtbo \
	allwinner/cubieboard-ng-spidev-overlay.dtbo \
	allwinner/cubieboard-ng-spisens-overlay.dtbo \
"
