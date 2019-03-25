# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils unpacker

DESCRIPTION="IDEMIA AWP Middleware for new Estonian ID cards"
HOMEPAGE="https://www.idemia.com"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
SLOT="0"
IUSE="+firefox"

SRC_URI="https://installer.id.ee/media/ubuntu/pool/main/a/awp/awp_${PV}_${ARCH}.deb"

RDEPEND="dev-libs/openssl:=
    >=dev-libs/nss-3.40
    >=dev-libs/opensc-0.18[pcsc-lite]"

DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_prepare() {
    # remove all useless things
    rm usr/local/AWP/awp_uninstall.sh  # debian 'uninstaller'
    if ! use firefox ; then
        # dispose of unwanted plugins
        rm -rf usr/lib  # mozilla/pkcs11-modules/
        rm -rf usr/share  # mozilla/extensions
    fi
    eapply_user
}

src_install() {
    # This will install libs to /usr/local, 
    # mozilla plugins to /usr/lib/mozilla/pkcs11-modules/
    # and /usr/share/mozilla/extensions
    # The library paths are hardcoded in qdigidoc so we just follow suit
    cp -R "${WORKDIR}/usr" "${PORTAGE_BUILDDIR}/image" || die "Install failed!"
}
