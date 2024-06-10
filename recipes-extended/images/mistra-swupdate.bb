require recipes-extended/images/mistra-image.bb

CORE_IMAGE_EXTRA_INSTALL += " \
    libubootenv-bin \
    swupdate \
    swupdate-www \
    kernel-image \
    kernel-devicetree \
"

IMAGE_FSTYPES = "ext4.gz wic.gz"
IMAGE_BOOT_FILES = "boot.scr"
IMAGE_FEATURES += "read-only-rootfs"

create_data_dir() {
   mkdir -p ${IMAGE_ROOTFS}/data
}

IMAGE_PREPROCESS_COMMAND += "create_data_dir;"

WKS_FILES = "mistra-swupdate.wks.in"
# Do not update fstab file when using wic images
WIC_CREATE_EXTRA_ARGS ?= "--no-fstab-update"
