# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake flag-o-matic xdg

DESCRIPTION="Digidoc4 client"
HOMEPAGE="https://github.com/open-eid/DigiDoc4-Client"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

# replace underscore for beta tarballs
MY_PV=$(ver_rs 3-4 _)

SRC_URI="https://github.com/open-eid/DigiDoc4-Client/releases/download/v${MY_PV}/${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

RDEPEND="dev-libs/openssl:=
	>=dev-libs/opensc-0.18[pcsc-lite]
	>=dev-libs/libdigidocpp-3.14.4
	dev-libs/xerces-c[icu]
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	net-nds/openldap
"

DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

DOCS="README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"

src_prepare() {
	eapply --fuzz=3 "${FILESDIR}/sandbox-compat.patch"
	sed -i 's/ Qt6 / /' CMakeLists.txt # configure fails if Qt6 is installed

	cmake_src_prepare

	# TSL.qrc: https://github.com/open-eid/qdigidoc/wiki/DeveloperTips#building-in-sandboxed-environment
	# EE.xml: https://sr.riik.ee/tsl/estonian-tsl.xml
	# eu-lotl.xml: https://ec.europa.eu/tools/lotl/eu-lotl.xml
	cp "${FILESDIR}"/{TSL.qrc,EE.xml,eu-lotl.xml}	"${S}"/client/
	# https://id.eesti.ee/config.{json,rsa,pub}
	cp "${FILESDIR}"/config.{json,rsa,pub}		"${S}"/common/
}
