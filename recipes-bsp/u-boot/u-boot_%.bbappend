FILESEXTRAPATHS:prepend:sunxi := "${THISDIR}/files:"

SRC_URI:append = "\
    file://bootcount.cfg \
    file://initramfs.cfg \
    file://spi_flash.cfg \
    file://0001-add-flash-to-dts.patch \
"

SRC_URI:append:mistra-recovery = "\
    file://of_embed.cfg \
"
