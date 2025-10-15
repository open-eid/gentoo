# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake flag-o-matic

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/libdigidocpp"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc java pdf"

SRC_URI="https://github.com/open-eid/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar"

RDEPEND="dev-libs/libxml2
	dev-libs/xmlsec
	>=dev-libs/opensc-0.14
	dev-libs/openssl:=
	sys-libs/zlib
	pdf? ( <app-text/podofo-0.9.5 )
	java? ( virtual/jre:= )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	java? ( dev-lang/swig virtual/jdk:= )
	|| ( dev-util/xxdi app-editors/vim-core )"

DOCS="AUTHORS RELEASE-NOTES.md README.md"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR="share/doc/${PF}/html"
		$(cmake_use_find_package doc Doxygen)
		$(cmake_use_find_package java SWIG)
		$(cmake_use_find_package pdf PoDoFo)
	)
	cmake_src_configure
}
