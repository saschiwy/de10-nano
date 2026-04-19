SUMMARY = "systemd-networkd configuration for DHCP on wired interfaces"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://10-wired.network"

S = "${WORKDIR}"

do_install() {
	install -d ${D}${sysconfdir}/systemd/network
	install -m 0644 ${WORKDIR}/10-wired.network ${D}${sysconfdir}/systemd/network/10-wired.network

	install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
	ln -sf /lib/systemd/system/systemd-networkd.service \
		${D}${sysconfdir}/systemd/system/multi-user.target.wants/systemd-networkd.service
}

FILES:${PN} = " \
	${sysconfdir}/systemd/network/10-wired.network \
	${sysconfdir}/systemd/system/multi-user.target.wants/systemd-networkd.service \
"

RDEPENDS:${PN} = "systemd"
