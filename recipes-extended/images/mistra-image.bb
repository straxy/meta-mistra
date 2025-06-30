require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL:append = "\
    lighttpd \
    i2c-tools \
"

IMAGE_INSTALL:append:cubieboard-ng = "\
    kernel-module-mmsens-drv \
    mmsens-app \
    i2csens-app \
"

TOOLCHAIN_HOST_TASK:append = "\
    nativesdk-rust \
    nativesdk-cargo \
"

SDK_TOOLCHAIN_LANGS:append = " rust"
