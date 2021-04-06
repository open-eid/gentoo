# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake flag-o-matic git-r3 eutils

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/libdigidocpp"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="-pdf -java"

EGIT_REPO_URI="https://github.com/open-eid/${PN}.git"

RDEPEND="dev-libs/libxml2
	dev-libs/xml-security-c
	>=dev-libs/opensc-0.14
	dev-libs/openssl:=
	sys-libs/zlib
	dev-libs/libdigidoc
	pdf? ( <app-text/podofo-0.9.5 )
	java? ( virtual/jre:= )"

DEPEND="${RDEPEND}
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
		$(cmake_use_find_package pdf PoDoFo)
		$(cmake_use_find_package java SWIG)
	)
	cmake_src_configure
}
