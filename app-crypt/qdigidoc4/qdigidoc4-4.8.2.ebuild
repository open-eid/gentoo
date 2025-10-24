# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake flag-o-matic xdg

DESCRIPTION="Digidoc4 client"
HOMEPAGE="https://github.com/open-eid/DigiDoc4-Client"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
BUILDNR="5377"

SRC_URI="https://github.com/open-eid/DigiDoc4-Client/releases/download/v${PV}/${P}.${BUILDNR}.tar.gz -> ${P}.tar.gz"

RDEPEND="dev-libs/openssl:=
	dev-libs/opensc[pcsc-lite]
	dev-libs/libdigidocpp
	dev-qt/qtbase:6[gui,network,widgets]
	dev-qt/qtsvg:6
	net-nds/openldap
	dev-libs/flatbuffers
"

DOCS="README.md"

src_prepare() {
	cmake_src_prepare

	# TSL.qrc: https://github.com/open-eid/qdigidoc/wiki/DeveloperTips#building-in-sandboxed-environment
	# EE.xml: https://sr.riik.ee/tsl/estonian-tsl.xml
	# eu-lotl.xml: https://ec.europa.eu/tools/lotl/eu-lotl.xml
	cp "${FILESDIR}"/{TSL.qrc,EE.xml,eu-lotl.xml}	"${S}"/client/
	# https://id.eesti.ee/config.{json,rsa,pub}
	cp "${FILESDIR}"/config.{json,rsa,pub}		"${S}"/common/
}
