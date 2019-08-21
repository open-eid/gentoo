# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils

DESCRIPTION="Estonian ID Card PKCS11 module loader"
HOMEPAGE="https://github.com/open-eid/firefox-pkcs11-loader/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

SRC_URI="https://github.com/open-eid/firefox-pkcs11-loader/archive/v${PV}.tar.gz"

src_compile() {
	cmake-utils_src_compile extension
}
