FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

PACKAGECONFIG_CONFARGS = ""

SRC_URI += " \
    file://09-swupdate-args \
    file://swupdate.cfg \
    file://handler.cfg \
    file://signature.cfg \
    file://${TOPDIR}/../sources/meta-mistra/certs/mistra-test.cert.pem \
    file://upgrade-done.service \
    "

DEPENDS += " curl systemd "

inherit systemd

SYSTEMD_SERVICE:${PN} += " upgrade-done.service"
FILES:${PN} += " ${systemd_unitdir}/system/upgrade-done.service"

do_install:append() {
    install -m 0644 ${WORKDIR}/09-swupdate-args ${D}${libdir}/swupdate/conf.d/
    sed -i "s#@MACHINE@#${MACHINE}#g" ${D}${libdir}/swupdate/conf.d/09-swupdate-args
    install -m 0644 ${TOPDIR}/../sources/meta-mistra/certs/mistra-test.cert.pem ${D}${libdir}/swupdate/

    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/upgrade-done.service ${D}${systemd_unitdir}/system/
}
