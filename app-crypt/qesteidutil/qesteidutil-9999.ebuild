# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit cmake-utils flag-o-matic git-r3

DESCRIPTION="ID-card utility"
HOMEPAGE="https://github.com/open-eid/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

EGIT_REPO_URI="https://github.com/open-eid/${PN}.git"

RDEPEND="dev-libs/openssl:=
	sys-apps/pcsc-lite
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-libs/xerces-c[icu]"

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
