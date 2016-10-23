# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: This ebuild is from (alex) overlay $

EAPI=5

inherit games cmake-utils

DESCRIPTION="Rally game focused on closed rally tracks with possible stunt elements."
HOMEPAGE="http://stuntrally.tuxfamily.org/"

SLOT="0"
LICENSE="GPL-3"
IUSE="dedicated +game editor +tracks"

KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/stuntrally/stuntrally/archive/${PV}.tar.gz -> ${P}.tar.gz
	tracks? ( https://github.com/stuntrally/tracks/archive/${PV}.tar.gz -> ${PN}-tracks-${PV}.tar.gz )
"

RDEPEND="
	game? (
		dev-games/ogre[cg,boost,ois,freeimage,opengl,zip]
		dev-games/mygui[ogre,-opengl]
		media-libs/libsdl2:0[haptic]
		media-libs/libvorbis
		media-libs/libogg
	)
	net-libs/enet:1.3
	"

DEPEND="${RDEPEND}
	dev-libs/boost
	virtual/libstdc++
	sys-devel/gcc:=
"
REQUIRED_USE="editor? ( game ) tracks? ( game )"

DOCS=( Readme.txt )

S=${WORKDIR}
CMAKE_BUILD_DIR=${WORKDIR}/build

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build dedicated MASTER_SERVER)
		$(cmake-utils_use_build game GAME)
		$(cmake-utils_use_build editor EDITOR)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}
