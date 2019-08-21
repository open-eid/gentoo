# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="eID signatures WebExtension native host component"
HOMEPAGE="https://github.com/open-eid/chrome-token-signing/wiki"
EID_INSTALLER_VERSION=18.10
SRC_URI="https://github.com/open-eid/chrome-token-signing/archive/v${PV}.tar.gz -> chrome-token-signing-${PV}.tar.gz
	https://github.com/open-eid/linux-installer/archive/v${EID_INSTALLER_VERSION}.tar.gz -> eid-installer-${EID_INSTALLER_VERSION}.tar.gz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+chrome +firefox"

RDEPEND="dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-libs/openssl:=
	>=dev-libs/opensc-0.14[pcsc-lite]
	app-crypt/ccid
	chrome? ( dev-libs/nss[utils] )
	firefox? ( www-plugins/firefox-pkcs11-loader )"

DEPEND="${RDEPEND}"
S="${S}/host-linux"

pkg_pretend() {
	if ! use chrome && ! use firefox ; then
		die "All browsers disabled. Select at least one supported browser."
	fi
}

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

	if use chrome ; then
		# nssdb update script for chrom{e,ium}
		dobin ../../linux-installer-${EID_INSTALLER_VERSION}/esteid-update-nssdb
		# and autostart file to run it on logon
		insinto /etc/xdg/autostart
		doins ../../linux-installer-${EID_INSTALLER_VERSION}/chrome-pkcs11.desktop

		# Chrome extension
		insinto /usr/share/google-chrome/extensions
		doins ../ckjefchnfjhjfedoccjbhjpbncimppeg.json
		# Chromium extension
		insinto /usr/share/chromium/extensions
		doins ../ckjefchnfjhjfedoccjbhjpbncimppeg.json

		# Chrome native host JSON
		insinto /etc/opt/chrome/native-messaging-hosts/
		doins ee.ria.esteid.json
		# Chromium native host JSON
		insinto /etc/chromium/native-messaging-hosts/
		doins ee.ria.esteid.json
	fi
	if use firefox ; then
		# Firefox extension
		insinto /usr/share/mozilla/extensions/\{ec8030f7-c20a-464f-9b0e-13a3a9e97384\}
		doins ../\{443830f0-1fff-4f9a-aa1e-444bafbc7319\}.xpi
		# Firefox native host JSON
		insinto /usr/$(get_libdir)/mozilla/native-messaging-hosts
		doins ff/ee.ria.esteid.json
	fi
}
