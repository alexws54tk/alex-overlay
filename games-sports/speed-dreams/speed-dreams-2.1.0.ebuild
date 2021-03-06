# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: This ebuild is from (alex) overlay $

EAPI=5
inherit eutils games cmake-utils

MY_VER="2.1.0-r5799"

DESCRIPTION="A fork of the famous open racing car simulator TORCS"
HOMEPAGE="http://speed-dreams.sourceforge.net/"
SRC_URI="mirror://sourceforge/speed-dreams/${PN}-src-base-${MY_VER}.tar.xz
	mirror://sourceforge/speed-dreams/${PN}-src-wip-cars-and-tracks-${MY_VER}.tar.xz
	mirror://sourceforge/speed-dreams/${PN}-src-hq-cars-and-tracks-${MY_VER}.tar.xz
	mirror://sourceforge/speed-dreams/${PN}-src-more-hq-cars-and-tracks-${MY_VER}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=media-libs/libpng-1.2.40:1.2
	media-libs/openal
	>=media-libs/plib-1.8.3
	>=net-libs/enet-1.2.2:=
	sys-libs/zlib
	virtual/glu
	virtual/jpeg:=
	virtual/opengl
	"
DEPEND="${RDEPEND}"

S=${WORKDIR}
CMAKE_BUILD_DIR=${WORKDIR}/build

#src_prepare() {
#	epatch "${FILESDIR}"/bindir.patch
#}

src_configure() {
	mycmakeargs+=(
		'-DCMAKE_NO_BUILTIN_CHRPATH:BOOL=ON'
		'-DOPTION_OFFICIAL_ONLY:BOOL=ON'
		'-DOPTION_DEBUG:BOOL=OFF'
		'-DOPTION_TRACE:BOOL=OFF'
		"-DCMAKE_INSTALL_PREFIX:STRING=${GAMES_PREFIX}"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install
	dodoc CHANGES.txt INSTALL.txt README.txt
	rm -rf COPYING.txt CHANGES.txt INSTALL.txt TODO.txt README.txt cmake
	dohtml -r doc/faq/*
	dohtml doc/userman/*
	newicon data/data/icons/icon.png ${PN}.png
	make_desktop_entry ${PN}-2 "Speed Dreams 2"
	prepgamesdirs
}
