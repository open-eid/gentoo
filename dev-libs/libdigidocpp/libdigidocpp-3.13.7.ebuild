# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils flag-o-matic eutils eapi7-ver

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/libdigidocpp"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="-pdf -java"

# replace underscore for beta versions
MY_PV=$(ver_rs 3-4 _)
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

SRC_URI="https://github.com/open-eid/${PN}/releases/download/v${MY_PV}/${MY_P}.tar.gz"

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
		epatch "${FILESDIR}/xxdi.patch"
	fi
	# xml-security-c 2.x compat, included in next release
	# https://github.com/open-eid/libdigidocpp/commit/b034d21a5f3422b29eddbe21fa385fa6fddd24b8
	eapply ${FILESDIR}/libdigidocpp-3.13.7-xml-sec-c-2.x-compat.patch
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package pdf PoDoFo)
		$(cmake-utils_use_find_package java SWIG)
	)
	cmake-utils_src_configure
}
