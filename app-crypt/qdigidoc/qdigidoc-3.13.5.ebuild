# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit cmake-utils flag-o-matic versionator

DESCRIPTION="Digidoc client"
HOMEPAGE="https://github.com/open-eid/qdigidoc"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

# replace underscore for beta tarballs
MY_PV=$(replace_version_separator '_' '-')
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

SRC_URI="https://github.com/open-eid/${PN}/releases/download/v${MY_PV}/${MY_P}.tar.gz"

RDEPEND="dev-libs/openssl:=
	>=dev-libs/opensc-0.14[pcsc-lite]
	>=dev-libs/libdigidocpp-3.13.2
	dev-libs/xerces-c[icu]
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5"

DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

DOCS="AUTHORS README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"
