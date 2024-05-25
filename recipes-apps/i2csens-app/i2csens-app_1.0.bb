DESCRIPTION = "I2C sensor userspace application"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=8b1d2c5611fa473ea97aadf83d3f6f12"

SRC_URI = "git://github.com/straxy/i2csens-app.git;protocol=https;branch=main"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

inherit cmake

