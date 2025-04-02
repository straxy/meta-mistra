require recipes-core/images/core-image-minimal.bb

INITRAMFS_SCRIPTS ?= "\
    initramfs-mistra \
"

PACKAGE_INSTALL = " \
    ${INITRAMFS_SCRIPTS} \
    ${VIRTUAL-RUNTIME_base-utils} \
    libubootenv-bin \
    swupdate \
    swupdate-www \
    base-passwd \
    openssl \
    util-linux-sfdisk \
    e2fsprogs-mke2fs \
    ${ROOTFS_BOOTSTRAP_INSTALL} \
"

# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = ""

# Don't allow the initramfs to contain a kernel
PACKAGE_EXCLUDE = "kernel-image-*"

IMAGE_NAME_SUFFIX ?= ""
IMAGE_LINGUAS = ""

LICENSE = "MIT"

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"
inherit core-image

IMAGE_ROOTFS_SIZE = "8192"
IMAGE_ROOTFS_EXTRA_SPACE = "0"

do_rootfs[depends] += "u-boot:do_deploy"

add_uboot_initial_env() {
    install -d ${IMAGE_ROOTFS}${sysconfdir}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot-initial-env ${IMAGE_ROOTFS}${sysconfdir}
}
ROOTFS_POSTPROCESS_COMMAND += "add_uboot_initial_env; "
