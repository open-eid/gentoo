# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils

DESCRIPTION="IDEMIA AWP Middleware for new Estonian ID cards"
HOMEPAGE="https://www.idemia.com"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+firefox"

# replace underscore for beta tarballs
MY_PV=$(ver_rs 1 _)

SRC_URI="https://installer.id.ee/media/ubuntu/pool/main/a/awp/awp_${PV}_${ARCH}.deb"

RDEPEND="dev-libs/openssl:=
    >=dev-libs/nss-3.40
    >=dev-libs/opensc-0.18[pcsc-lite]"

DEPEND="${RDEPEND}"

src_unpack() {
    # extract 3 debian files out of .deb (to ${WORKDIR})
    unpack "${A}"
    # extract the main archive
    unpack "${WORKDIR}/data.tar.gz"
    mkdir "${S}"
    mv usr "${S}"
}

src_prepare() {
    # remove all useless things
    cd "${S}"
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
    cp -R "${S}/usr" "${PORTAGE_BUILDDIR}/image" || die "Install failed!"
}
