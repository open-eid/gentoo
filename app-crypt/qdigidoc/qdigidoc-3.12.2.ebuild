# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils flag-o-matic git-r3

DESCRIPTION="Digidoc client"
HOMEPAGE="https://github.com/open-eid/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

EGIT_REPO_URI="https://github.com/open-eid/${PN}.git"
#if !LIVE
EGIT_COMMIT="v${PV}"
#endif

RDEPEND="dev-libs/openssl:=
	>=dev-libs/opensc-0.14
	>=dev-libs/libdigidocpp-3.12.0
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
