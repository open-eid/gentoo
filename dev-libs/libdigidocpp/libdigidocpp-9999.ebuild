# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
PYTHON_COMPAT=( python3_{11..14} )

inherit cmake flag-o-matic git-r3 python-single-r1

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/libdigidocpp"
LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="doc dotnet java python test ${PYTHON_SINGLE_USEFLAG}"
REQUIRED_USE="python? ( ${PYTHON_SINGLE_USEFLAG} )"

EGIT_REPO_URI="https://github.com/open-eid/${PN}.git"

RDEPEND="dev-libs/libxml2
	dev-libs/xmlsec[openssl]
	dev-libs/opensc
	dev-libs/openssl:=
	sys-libs/zlib
	java? ( virtual/jre:= )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dotnet? ( dev-lang/swig )
	java? ( dev-lang/swig virtual/jdk:= )
	python? ( dev-lang/swig ${PYTHON_DEPS} )
	test? ( dev-libs/boost )"

DOCS="AUTHORS RELEASE-NOTES.md README.md"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR="share/doc/${PF}/html"
		-DCMAKE_DISABLE_FIND_PACKAGE_SWIG=$(use java || use dotnet || use python && echo OFF || echo ON)
		$(cmake_use_find_package doc Doxygen)
		$(cmake_use_find_package python Python3)
		$(cmake_use_find_package test Boost)
	)
	cmake_src_configure
}
