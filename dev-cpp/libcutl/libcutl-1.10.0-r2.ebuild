# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit autotools flag-o-matic

DESCRIPTION="A collection of C++ libraries (successor of libcult)"
HOMEPAGE="http://www.codesynthesis.com/projects/libcutl/"
SRC_URI="http://www.codesynthesis.com/download/${PN}/$(ver_cut 1-2)/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.10.0-fix-c++14.patch
	"${FILESDIR}"/${PN}-1.10.0-boost-1.65-tr1.patch
	"${FILESDIR}"/${PN}-1.10.0-perl-regex.patch
)

src_prepare() {
	default

	# remove bundled libs
	rm -r cutl/details/{boost,expat} || die

	eautoreconf
}

src_configure() {
	# ensure <regex> works on GCC 5 and below
	# bug 630016
	append-cxxflags -std=c++14

	econf \
		--disable-static \
		--with-external-boost \
		--with-external-expat
}

src_install() {
	default

	# package provides .pc files
	find "${D}" -name '*.la' -delete || die
}
