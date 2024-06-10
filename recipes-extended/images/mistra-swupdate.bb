require recipes-extended/images/mistra-image.bb

CORE_IMAGE_EXTRA_INSTALL += " \
    libubootenv-bin \
    swupdate \
    swupdate-www \
    kernel-image \
    kernel-devicetree \
"

WKS_FILES = "mistra-swupdate.wks.in"
IMAGE_FSTYPES = "ext4.gz wic.gz"
IMAGE_BOOT_FILES = "boot.scr"
IMAGE_FEATURES += "read-only-rootfs"

create_data_dir() {
   mkdir -p ${IMAGE_ROOTFS}/data
}

IMAGE_PREPROCESS_COMMAND += "create_data_dir;"
