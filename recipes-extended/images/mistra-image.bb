require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL:append = "\
    lighttpd \
    i2c-tools \
    libgpiod \
    libgpiod-tools \
"

IMAGE_INSTALL:append:cubieboard-ng = "\
    kernel-module-mmsens-drv \
    kernel-module-i2csens-drv \
    kernel-module-spisens-drv \
    mmsens-app \
    i2csens-app \
    sens-apps \
    sens-app-mongoose \
"

TOOLCHAIN_HOST_TASK:append = "\
    nativesdk-rust \
    nativesdk-cargo \
"

SDK_TOOLCHAIN_LANGS:append = " rust"
