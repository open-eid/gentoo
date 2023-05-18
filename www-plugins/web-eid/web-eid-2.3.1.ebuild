# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake git-r3

DESCRIPTION="Web eID browser extension and helper application"
HOMEPAGE="
	https://web-eid.eu/
	https://github.com/web-eid/web-eid-app
"
LICENSE="MIT"
SLOT="0"
IUSE=""

EGIT_REPO_URI="https://github.com/web-eid/web-eid-app.git"
if [[ ${PV} != *"9999" ]]; then
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64"
fi

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

# TODO Make the build not download the Firefox xpi.
# TODO The Firefox extension that gets installed is ignored.
#      Either edit /usr/lib64/firefox/distribution/policies.json on install and uninstall
#      or instruct the user to do that or to install the extension from addons.mozilla.org.
