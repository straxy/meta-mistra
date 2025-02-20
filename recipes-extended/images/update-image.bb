DESCRIPTION = "Example image demonstrating how to build SWUpdate compound image"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit swupdate

SWUPDATE_SIGNING="CMS"
SWUPDATE_CMS_CERT="${TOPDIR}/../sources/meta-mistra/certs/mistra-test.cert.pem"
SWUPDATE_CMS_KEY="${TOPDIR}/../sources/meta-mistra/certs/mistra-test.key.pem"

SRC_URI = "\
    file://shellscript.sh \
    file://sw-description \
"

# images to build before building swupdate image
IMAGE_DEPENDS = "\
    virtual/bootloader \
    mistra-swupdate \
"

# images and files that will be included in the .swu image
SWUPDATE_IMAGES = "\
    ${SPL_BINARY} \
    mistra-swupdate-cubieboard-ng.rootfs \
"

SWUPDATE_IMAGES_FSTYPES[mistra-swupdate-cubieboard-ng.rootfs] = ".ext4.gz"
