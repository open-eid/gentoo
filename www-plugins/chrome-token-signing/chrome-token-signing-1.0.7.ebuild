# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="eID signatures WebExtension native host component"
HOMEPAGE="https://github.com/open-eid/chrome-token-signing/wiki"
SRC_URI="https://github.com/open-eid/chrome-token-signing/archive/v${PV}.tar.gz -> chrome-token-signing-${PV}.tar.gz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-libs/openssl:=
	>=dev-libs/opensc-0.14[pcsc-lite]
	app-crypt/ccid"
DEPEND="${RDEPEND}"
S="${S}/host-linux"

src_prepare() {
	default
	rm GNUmakefile || die # avoid any chance of using this instead of qmake stuff
	sed -i -e "s:INSTALLS += target hostconf ffconf extension ffextension:INSTALLS += target ffconf extension ffextension:" \
		chrome-token-signing.pro || die
}

src_configure() {
	eqmake5
}

src_install() {
	# Native component
	dobin chrome-token-signing
	# Chrome extension
	insinto /usr/share/google-chrome/extensions
	doins ../ckjefchnfjhjfedoccjbhjpbncimppeg.json
	# Chromium extension
	insinto /usr/share/chromium/extensions
	doins ../ckjefchnfjhjfedoccjbhjpbncimppeg.json
	# Firefox extension
	insinto /usr/share/mozilla/extensions/\{ec8030f7-c20a-464f-9b0e-13a3a9e97384\}
	doins ../\{443830f0-1fff-4f9a-aa1e-444bafbc7319\}.xpi

	# Chrome native host JSON
	insinto /etc/opt/chrome/native-messaging-hosts/
	doins ee.ria.esteid.json
	# Chromium native host JSON
	insinto /etc/chromium/native-messaging-hosts/
	doins ee.ria.esteid.json
	# Firefox JSON
	insinto /usr/$(get_libdir)/mozilla/native-messaging-hosts
	doins ff/ee.ria.esteid.json
}
