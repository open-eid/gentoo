# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI="8"

inherit cmake

LEIDV="2.8.0"
LEIDF="libelectronic-id-${LEIDV}"
XPIV="2.4.1"
XPIF="web_eid_webextension-${XPIV}.xpi"

if [[ ${PV} == *"9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/web-eid/web-eid-app.git"
	MYCMAKEARGS="-DBUNDLE_XPI=ON"
else
	SRC_URI="https://github.com/web-eid/web-eid-app/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/web-eid/libelectronic-id/archive/refs/tags/v${LEIDV}.tar.gz -> ${LEIDF}.tar.gz
		https://addons.mozilla.org/firefox/downloads/latest/web-eid-webextension/${XPIF}"
	S="${WORKDIR}/${PN}-app-${PV}"
	MYCMAKEARGS="-DBUNDLE_XPI=OFF"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Web eID browser extension and helper application"
HOMEPAGE="https://web-eid.eu/"
LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND="dev-libs/openssl:0=
        dev-qt/qtbase:6=[network,widgets]
        dev-qt/qtsvg:6=
        sys-apps/pcsc-lite"


DEPEND="${RDEPEND}"

BDEPEND="
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig
	test? ( dev-cpp/gtest:0= )
"

DOCS="README.md"

if [[ ${PV} != *"9999" ]]; then
	src_unpack() {
		default
		rmdir "${S}/lib/libelectronic-id"
		mv "${WORKDIR}/${LEIDF}" "${S}/lib/libelectronic-id"
	}
fi

src_prepare() {
	default
	if [[ ${PV} != *"9999" ]]; then
		# The bundled xpi is outdated, replace it with the latest one
		mv "${WORKDIR}/${XPIF}" "${S}/install/${XPIF}"
	fi

	if ! use test ; then
			sed -i '/enable_testing()/,$d' {,lib/libelectronic-id/,lib/libelectronic-id/lib/libpcsc-cpp/,lib/libelectronic-id/lib/libpcsc-cpp/tests/lib/libpcsc-mock/}CMakeLists.txt \
			|| die "sed failed"
    fi
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	)
	cmake_src_configure
}

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
