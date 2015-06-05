# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils flag-o-matic versionator

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://id.ee/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

MY_PV=$(replace_version_separator '_' '-')
MY_P="${PN}-${MY_PV}"

SRC_URI="https://github.com/open-eid/${PN}/archive/v${MY_PV}/${MY_P}.tar.gz"

RDEPEND="dev-libs/libxml2
	dev-libs/xml-security-c
	dev-libs/opensc
	dev-libs/openssl:=
	sys-libs/zlib
	dev-libs/libdigidoc"

DEPEND="${RDEPEND}
	>=dev-cpp/xsd-4.0.0"

DOCS="AUTHORS RELEASE-NOTES.txt README.md"

# gentoo specific zlib internal macro names
append-cppflags "-DOF=_Z_OF"
