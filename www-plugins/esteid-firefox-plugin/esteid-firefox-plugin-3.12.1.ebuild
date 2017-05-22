# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"
inherit multilib

MY_PN="browser-token-signing"
MY_PV="${PV/_beta/-beta}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Estonian ID card digital signing browser plugin"
HOMEPAGE="https://github.com/open-eid/"
SRC_URI="https://github.com/open-eid/${MY_PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-autoloader"

CDEPEND="x11-libs/gtk+:2
	dev-libs/openssl"

DEPEND="${CDEPEND}
	sys-devel/gcc"

RDEPEND="${CDEPEND}
	>=dev-libs/opensc-0.14[pcsc-lite]
	autoloader? ( >=www-plugins/firefox-pkcs11-loader-3.11.0 )
	|| ( <www-client/firefox-bin-52.0 <www-client/firefox-52.0 )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake plugin
}

src_install() {
	insinto "/usr/$(get_libdir)/nsbrowser/plugins/"
	doins npesteid-firefox-plugin.so
	dodoc README.txt RELEASE-NOTES.txt
}

pkg_postinst() {
	ewarn "If autoloader flag is not set, esteid-firefox-plugin will not work"
	ewarn "unless you add onepin-opensc-pkcs11.so from dev-libs/opensc"
	ewarn "as a security device in Firefox settings."
}
