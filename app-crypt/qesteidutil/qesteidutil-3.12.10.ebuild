# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils flag-o-matic eapi7-ver

DESCRIPTION="ID-card utility"
HOMEPAGE="https://github.com/open-eid/qesteidutil"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

# replace underscore for beta tarballs
MY_PV=$(ver_rs 3-4 _)
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

SRC_URI="https://github.com/open-eid/${PN}/releases/download/v${MY_PV}/${MY_P}.tar.gz"

RDEPEND="dev-libs/openssl:=
	sys-apps/pcsc-lite
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-libs/xerces-c[icu]"

DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

PATCHES=(
	"${FILESDIR}/missing-qt-includes.patch"
)

DOCS="AUTHORS README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"

src_configure() {
# disable Breakpad integration
local mycmakeargs=( '-DBREAKPAD=FALSE' )
cmake-utils_src_configure
}
