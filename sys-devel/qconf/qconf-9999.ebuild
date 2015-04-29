# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca/qca-2.0.0-r2.ebuild,v 1.8 2008/03/15 11:30:02 corsair Exp $

EAPI="5"

inherit multilib git-2

DESCRIPTION="Qt ./configure generation util"
HOMEPAGE="http://delta.affinix.com/qconf/"
EGIT_REPO_URI="git://github.com/psi-plus/qconf.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+qt5"
#RESTRICT="test strip"

DEPEND="dev-qt/qtcore"
RDEPEND="${DEPEND}"

export QT_SELECT="qt5"

src_configure() {
	./configure \
		--prefix="${EPREFIX}"/usr \
		--qtdir="${EPREFIX}"/usr/$(get_libdir)/${QT_SELECT}/ || die "./configure failed"
	"${EPREFIX}"/usr/bin/qmake \
		QTDIR="${EPREFIX}"/usr/$(get_libdir)/${QT_SELECT}/ \
			QMAKE="${EPREFIX}"/usr/bin/qmake \
			QMAKE_CC="$(tc-getCC)" \
			QMAKE_CXX="$(tc-getCXX)" \
			QMAKE_LINK="$(tc-getCXX)" \
			QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
			QMAKE_CXXFLAGS_DEBUG="${CXXFLAGS}" \
			QMAKE_LFLAGS_RELEASE="${LDFLAGS}" \
			QMAKE_LFLAGS_DEBUG="${LDFLAGS}" \
			QMAKE_LIBDIR_QT="${EPREFIX}"/usr/$(get_libdir)/${QT_SELECT}/ \
			QMAKE_LIBDIR_X11="${EPREFIX}"/usr/$(get_libdir) \
			QMAKE_LIBDIR_OPENGL="${EPREFIX}"/usr/$(get_libdir) \
			QMAKE_STRIP= || die "qmake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
