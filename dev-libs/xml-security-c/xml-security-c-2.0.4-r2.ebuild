# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="Apache C++ XML security libraries"
HOMEPAGE="https://santuario.apache.org/"
SRC_URI="mirror://apache/santuario/c-library/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug examples libressl nss static-libs"

RDEPEND=">=dev-libs/xerces-c-3.2
	dev-libs/xalan-c
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	nss? ( dev-libs/nss )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	dev-libs/xalan-c"

DOCS=( CHANGELOG.txt NOTICE.txt )

src_configure() {
	econf \
		--with-openssl \
		--with-xalan \
		$(use_enable static-libs static) \
		$(use_enable debug) \
		$(use_with nss)
}

src_install() {
	default
	if use examples ; then
		docinto examples
		dodoc xsec/samples/*.cpp
	fi
}
