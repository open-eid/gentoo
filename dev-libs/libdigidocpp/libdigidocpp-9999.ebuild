# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake flag-o-matic git-r3

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/libdigidocpp"
LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="doc java pdf"

EGIT_REPO_URI="https://github.com/open-eid/${PN}.git"

RDEPEND="dev-libs/libxml2
	>=dev-libs/xml-security-c-2.0.4
	>=dev-libs/opensc-0.14
	dev-libs/xalan-c
	dev-libs/openssl:=
	sys-libs/zlib
	pdf? ( <app-text/podofo-0.9.5 )
	java? ( virtual/jre:= )"

DEPEND="${RDEPEND}
	doc? ( app-text/doxygen )
	>=dev-cpp/xsd-4.0.0
	>=dev-cpp/libcutl-1.10.0-r1
	java? ( dev-lang/swig virtual/jdk:= )
	|| ( dev-util/xxdi app-editors/vim-core )"

DOCS="AUTHORS RELEASE-NOTES.md README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"

src_prepare() {
	if ! has_version app-editors/vim-core; then
		eapply "${FILESDIR}/xxdi.patch"
	fi
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR="share/doc/${PF}/html"
		$(cmake_use_find_package doc Doxygen)
		$(cmake_use_find_package java SWIG)
		$(cmake_use_find_package pdf PoDoFo)
	)
	cmake_src_configure
}
