DESCRIPTION = "Memory-mapped sensor userspace application"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e983ef1fada174da9affb3753a18936f"

SRC_URI = "git://github.com/straxy/mmsens-app.git;protocol=https;branch=main"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

inherit cmake

