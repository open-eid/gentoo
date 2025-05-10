# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI="8"

inherit cmake

LEIDV="1.2.0"
LEIDF="libelectronic-id-${LEIDV}"
LPCV="1.2.0"
LPCF="libpcsc-cpp-${LPCV}"
LPMV="1.0.0"
LPMF="libpcsc-mock-${LPMV}"
XPIV="2.2.1"
XPIF="web_eid_webextension-${XPIV}.xpi"

if [[ ${PV} == *"9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/web-eid/web-eid-app.git"
	MYCMAKEARGS="-DBUNDLE_XPI=ON"
else
	SRC_URI="https://github.com/web-eid/web-eid-app/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/web-eid/libelectronic-id/archive/refs/tags/v${LEIDV}.tar.gz -> ${LEIDF}.tar.gz
		https://github.com/web-eid/libpcsc-cpp/archive/refs/tags/v${LPCV}.tar.gz -> ${LPCF}.tar.gz
		https://github.com/web-eid/libpcsc-mock/archive/refs/tags/${LPMV}.tar.gz -> ${LPMF}.tar.gz
		https://addons.mozilla.org/firefox/downloads/latest/web-eid-webextension/${XPIF}"
	S="${WORKDIR}/${PN}-app-${PV}"
	MYCMAKEARGS="-DBUNDLE_XPI=OFF"
	PATCHES=(
		"${FILESDIR}/${P}_fix_pcsc_mock_include.patch"
		"${FILESDIR}/${P}_fix_native_messaging.patch"
	)
	KEYWORDS="~amd64"
fi

DESCRIPTION="Web eID browser extension and helper application"
HOMEPAGE="https://web-eid.eu/"
LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	sys-apps/pcsc-lite
	>=dev-libs/openssl-1.1.1:=
	dev-qt/qtcore
	dev-qt/qtwidgets
	dev-qt/qtnetwork
	dev-qt/qtsvg
"

DEPEND="
	${RDEPEND}
	dev-qt/linguist-tools
	dev-qt/qttest
	dev-cpp/gtest
"

DOCS="README.md"

if [[ ${PV} != *"9999" ]]; then
	src_unpack() {
		default
		rmdir "${WORKDIR}/${LPCF}/tests/lib/libpcsc-mock"
		rmdir "${WORKDIR}/${LEIDF}/lib/libpcsc-cpp"
		rmdir "${S}/lib/libelectronic-id"
		mv "${WORKDIR}/${LPMF}" "${WORKDIR}/${LPCF}/tests/lib/libpcsc-mock"
		mv "${WORKDIR}/${LPCF}" "${WORKDIR}/${LEIDF}/lib/libpcsc-cpp"
		mv "${WORKDIR}/${LEIDF}" "${S}/lib/libelectronic-id"
	}
fi
src_install() {
	default
	cmake_src_install
	if [[ ${PV} != *"9999" ]]; then
		insinto "/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
		newins "${DISTDIR}/${XPIF}" "{e68418bc-f2b0-4459-a9ea-3e72b6751b07}.xpi"
	else
		#Fix installation for live repo until https://github.com/web-eid/web-eid-app/issues/308 is fixed
		insinto "/usr/share/chromium/extensions/"
		doins "${S}/install/ncibgoaomkmdpilpocfeponihegamlic.json"
		insinto "/etc/opt/chrome/native-messaging-hosts/"
		doins "${BUILD_DIR}/src/app/eu.webeid.json"
		insinto "/etc/chromium/native-messaging-hosts/"
		doins "${BUILD_DIR}/src/app/eu.webeid.json"
	fi
}

pkg_postinst() {
		elog "To use the firefox plugin you will need to restart firefox and enable it manually"
}
