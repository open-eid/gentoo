# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit mozextension

DESCRIPTION="Estonian ID Card PKCS11 module loader"
HOMEPAGE="https://github.com/open-eid/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

SRC_URI="https://github.com/open-eid/firefox-pkcs11-loader/releases/download/v3.12.0/firefox-pkcs11-loader_3.12.0-fx.xpi"

S=${WORKDIR}

src_unpack() {
	xpi_unpack "firefox-pkcs11-loader_3.12.0-fx.xpi"
}

src_prepare() {
	mv firefox-pkcs11-loader_3.12.0-fx {aa84ce40-4253-a00a-8cd6-0800200f9a67} || die
}

src_install() {
	insinto /usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}
	doins -r {aa84ce40-4253-a00a-8cd6-0800200f9a67}
}
