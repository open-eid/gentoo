# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils eutils flag-o-matic versionator xdg-utils

DESCRIPTION="Digidoc4 client"
HOMEPAGE="https://github.com/open-eid/DigiDoc4-Client"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

# replace underscore for beta tarballs
MY_PV=$(replace_version_separator '_' '-')
MY_P="${PN}_${MY_PV}"

SRC_URI="https://github.com/open-eid/DigiDoc4-Client/releases/download/v${MY_PV}/${P}.tar.gz"

PATCHES=(
	"${FILESDIR}/sandbox-compat.patch"
)

RDEPEND="dev-libs/openssl:=
	>=dev-libs/opensc-0.18[pcsc-lite]
	>=dev-libs/libdigidocpp-3.13.2
	dev-libs/xerces-c[icu]
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	!app-crypt/qdigidoc"

DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

DOCS="README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"

src_prepare() {
	cmake-utils_src_prepare

	# TSL.qrc: https://github.com/open-eid/qdigidoc/wiki/DeveloperTips#building-in-sandboxed-environment
	# EE.xml: https://sr.riik.ee/tsl/estonian-tsl.xml
	# tl-mp.xml: https://ec.europa.eu/information_society/policy/esignature/trusted-list/tl-mp.xml
	cp "${FILESDIR}"/{TSL.qrc,EE.xml,tl-mp.xml}	"${S}"/client/
	# https://id.eesti.ee/config.(json|rsa|pub)
	cp "${FILESDIR}"/config.{json,rsa,pub}		"${S}"/common/
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
