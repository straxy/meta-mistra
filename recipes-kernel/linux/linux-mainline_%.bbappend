FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:cubieboard = "\
	file://axp20x.cfg \
"

SRC_URI:append:cubieboard-ng = "\
	file://sun4i-a10.dtsi-Update-for-custom-memory-mapped-device.patch \
"
