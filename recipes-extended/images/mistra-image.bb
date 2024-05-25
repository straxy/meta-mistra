require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL += "\
    lighttpd \
    i2c-tools \
"

IMAGE_INSTALL:append:cubieboard-ng = "\
    kernel-module-mmsens-drv \
    mmsens-app \
    i2csens-app \
"
