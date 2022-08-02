# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake flag-o-matic

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="-doc"

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
		$(cmake_use_find_package doc Doxygen)
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DCMAKE_INSTALL_DOCDIR="share/doc/${PF}"
	)
	cmake_src_configure
}
