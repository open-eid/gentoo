# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit cmake-utils flag-o-matic eutils versionator

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

# replace underscore for beta versions
MY_PV=$(replace_version_separator '_' '-')
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

SRC_URI="https://github.com/open-eid/${PN}/releases/download/v${MY_PV}/${MY_P}.tar.gz"

RDEPEND="dev-libs/libxml2
	dev-libs/xml-security-c
	>=dev-libs/opensc-0.14
	dev-libs/openssl:=
	sys-libs/zlib
	dev-libs/libdigidoc"

DEPEND="${RDEPEND}
	>=dev-cpp/xsd-4.0.0
        >=dev-cpp/libcutl-1.10.0-r1
	|| ( dev-util/xxdi app-editors/vim-core )"

DOCS="AUTHORS RELEASE-NOTES.md README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"

src_prepare() {
	if ! has_version app-editors/vim-core; then
		epatch "${FILESDIR}/xxdi.patch"
	fi
}
