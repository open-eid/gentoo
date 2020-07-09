# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit mozextension multilib

DESCRIPTION="Estonian ID Card PKCS11 module loader"
HOMEPAGE="https://github.com/open-eid/firefox-pkcs11-loader/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

SRC_URI="https://github.com/open-eid/firefox-pkcs11-loader/archive/v${PV}.tar.gz"

src_install() {
	insinto "${EPREFIX}/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
	doins "{02274e0c-d135-45f0-8a9c-32b35110e10d}.xpi"
	insinto ${EPREFIX}/usr/$(get_libdir)/mozilla/pkcs11-modules
	doins idemiaawppkcs11.json
	doins onepinopenscpkcs11.json
	dodoc README.md AUTHORS
}
