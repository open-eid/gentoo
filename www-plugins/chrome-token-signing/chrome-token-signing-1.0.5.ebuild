# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit qmake-utils git-r3

DESCRIPTION="Give signatures with your eID on the web"
HOMEPAGE="https://github.com/open-eid/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="firefox"

EGIT_REPO_URI="https://github.com/open-eid/${PN}.git"
#if !LIVE
EGIT_COMMIT="v${PV}"
#endif

RDEPEND="dev-libs/openssl:=
	>=dev-libs/opensc-0.14[pcsc-lite]
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	firefox? ( || ( >=www-client/firefox-bin-52 >=www-client/firefox-52 ) )"

DEPEND="${RDEPEND}"

DOCS="AUTHORS README.md RELEASE-NOTES.md"

src_prepare() {
		# unneeded, just calls qmake and forwards to generated makefile
		rm host-linux/GNUmakefile
		# enable them again depending on use flags
		epatch "${FILESDIR}/disable-browser-plugins-default.patch"
}

src_configure() {
		cd host-linux
		use firefox && echo "INSTALLS += ffconf ffextension" >> chrome-token-signing.pro
		eqmake5
}

src_install() {
		emake -C host-linux/ INSTALL_ROOT="${D}" install
}
