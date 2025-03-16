FILESEXTRAPATHS:prepend:sunxi := "${THISDIR}/files:"

SRC_URI:append = "\
    file://bootcount.cfg \
    file://initramfs.cfg \
"
