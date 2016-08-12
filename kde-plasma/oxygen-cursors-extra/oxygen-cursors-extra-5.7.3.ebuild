# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils eutils

DESCRIPTION="KDE's Oxygen mouse cursor theme - the extra flavours"
HOMEPAGE="https://projects.kde.org/projects/kde/workspace/oxygen"
MY_P=oxygen-${PV}

SRC_URI="mirror://kde/stable/plasma/${PV}/${MY_P}.tar.xz"
KEYWORDS="amd64 x86"
IUSE=""
SLOT="0"
LICENSE="LGPL-3"

# Theme list
COLOURS="bluecurve brown cherry chrome desert emerald green grey honeycomb hot_orange lilac midnight_meadow navy norway obsidian obsidian-hc olympus olympus-inv orchid oxygen peach purple red red-argentina sea_blue steel terra terra_green violet viorange whitewater wonton"

RDEPEND=""

DEPEND="${RDEPEND}
	dev-util/cmake
	app-arch/tar
	media-gfx/inkscape
	dev-libs/libltdl
	x11-apps/xcursorgen"

S="${WORKDIR}/${MY_P}/cursors/src"

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
#	cmake-utils_src_install
	cd "${WORKDIR}/${P}_build"
	for COLOUR in ${COLOURS}; do
		dodir /usr/share/cursors/xorg-x11/oxy-${COLOUR}
		insinto /usr/share/cursors/xorg-x11/oxy-${COLOUR}
		doins -r oxy-${COLOUR}/cursors || die "doins ${COLOUR} failed"
		doins oxy-${COLOUR}/index.theme || die "doins ${COLOUR} failed"
	done
}
