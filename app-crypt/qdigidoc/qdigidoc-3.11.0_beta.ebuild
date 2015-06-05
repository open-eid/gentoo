# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils flag-o-matic versionator

DESCRIPTION="Digidoc client"
HOMEPAGE="https://id.ee/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

MY_PV=$(replace_version_separator '_' '-')
MY_P="${PN}-${MY_PV}"

SRC_URI="https://github.com/open-eid/${PN}/archive/v${MY_PV}/${MY_P}.tar.gz"

RDEPEND="dev-libs/openssl:=
	dev-libs/opensc
	>=dev-libs/libdigidocpp-3.10.0
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5"

DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

DOCS="AUTHORS README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"

src_configure() {
# disable Breakpad integration
local mycmakeargs=( '-DBREAKPAD=""' )
cmake-utils_src_configure
}
