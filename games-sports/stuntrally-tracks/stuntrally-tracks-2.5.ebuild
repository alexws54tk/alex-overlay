# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit games cmake-utils

DESCRIPTION="A set of tracks for ${CATEGORY}/${P//-tracks}"
HOMEPAGE="http://stuntrally.tuxfamily.org/cars"

SLOT="0"
LICENSE="GPL3"
IUSE=""

SRC_URI="https://github.com/stuntrally/tracks/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/tracks"

RDEPEND="=${CATEGORY}/${P//-tracks}"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs+=(
		-DSHARE_INSTALL="/usr/share/games/stuntrally"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}
