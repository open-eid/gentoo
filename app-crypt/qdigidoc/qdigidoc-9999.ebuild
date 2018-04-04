# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils eutils flag-o-matic git-r3

DESCRIPTION="Digidoc client"
HOMEPAGE="https://github.com/open-eid/qdigidoc"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

EGIT_REPO_URI="https://github.com/open-eid/${PN}.git"

PATCHES=(
	"${FILESDIR}/sandbox-compat.patch"
)

RDEPEND="dev-libs/openssl:=
	>=dev-libs/opensc-0.14[pcsc-lite]
	>=dev-libs/libdigidocpp-3.13.2
	dev-libs/xerces-c[icu]
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5"

DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

DOCS="AUTHORS README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"
