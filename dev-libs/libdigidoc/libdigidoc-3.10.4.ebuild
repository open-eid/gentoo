# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils flag-o-matic

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

SRC_URI="https://github.com/open-eid/${PN}/releases/download/v${PV}/${P}.tar.gz"

RDEPEND="dev-libs/libxml2
	>=dev-libs/opensc-0.14
	dev-libs/openssl:=
	sys-libs/zlib"
DEPEND="doc? ( app-doc/doxygen )
	${RDEPEND}"

DOCS="AUTHORS RELEASE-NOTES.md README.md"

PATCHES=(
	"${FILESDIR}"/fix-library-file-name.patch
)

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"

src_configure(){
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	)
	cmake-utils_src_configure
}
