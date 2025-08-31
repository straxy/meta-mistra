FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:cubieboard = "\
	file://axp20x.cfg \
"

SRC_URI:append:mistra-recovery = "\
	file://initramfs.cfg \
"

SRC_URI:append:cubieboard-ng = "\
	file://sun4i-a10.dtsi-Update-for-custom-memory-mapped-device.patch \
	file://sun4i-cubieboard-Add-spidev-to-dts.patch \
	file://sun4i-cubieboard-Enable-UART1-in-DTS.patch \
	file://sun4i-cubieboard-Add-i2csens-node.patch \
"
