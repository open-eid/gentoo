# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils flag-o-matic git-r3 eutils

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

EGIT_REPO_URI="https://github.com/open-eid/${PN}.git"

RDEPEND="dev-libs/libxml2
	dev-libs/xml-security-c
	>=dev-libs/opensc-0.14
	dev-libs/openssl:=
	sys-libs/zlib
	dev-libs/libdigidoc"

DEPEND="${RDEPEND}
	>=dev-cpp/xsd-4.0.0
	|| ( dev-util/xxdi app-editors/vim-core )"

DOCS="AUTHORS RELEASE-NOTES.txt README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"

src_prepare() {
	if ! has_version app-editors/vim-core; then
		epatch "${FILESDIR}/xxdi.patch"
	fi
}
