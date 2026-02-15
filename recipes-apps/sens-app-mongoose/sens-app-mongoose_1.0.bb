DESCRIPTION = "Mongoose web server dashboard application"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=ed27a14fac2791e45d0709edc3443ab8"

FILESEXTRAPATHS:prepend = "${THISDIR}/files:"

SRC_URI = "\
    git://github.com/straxy/sens-app-mongoose.git;protocol=https;branch=main \
    file://sens-app-mongoose.service \
"

SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

TARGET_CC_ARCH += "${LDFLAGS}"

do_install() {
    # Install executable
    install -d ${D}${bindir}
    install -m 0755 ${S}/firmware ${D}${bindir}/sens-app-mongoose

    # Install service file
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/sens-app-mongoose.service ${D}${systemd_system_unitdir}/
}

inherit systemd

SYSTEMD_SERVICE:${PN} = "sens-app-mongoose.service"
