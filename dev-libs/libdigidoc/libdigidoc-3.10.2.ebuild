# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils flag-o-matic

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

SRC_URI="https://github.com/open-eid/${PN}/releases/download/v${PV}/${P}.tar.gz"

RDEPEND="dev-libs/libxml2
	dev-libs/opensc
	dev-libs/openssl:=
	sys-libs/zlib"
DEPEND="${RDEPEND}"

DOCS="AUTHORS RELEASE-NOTES.txt README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"
