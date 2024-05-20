require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL += "\
    lighttpd \
"

IMAGE_INSTALL:append:cubieboard-ng = "\
    kernel-module-mmsens-drv \
    mmsens-app \
"
