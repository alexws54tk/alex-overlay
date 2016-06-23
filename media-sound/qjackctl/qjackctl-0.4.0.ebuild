# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="A Qt application to control the JACK Audio Connection Kit and ALSA sequencer connections"
HOMEPAGE="http://qjackctl.sourceforge.net/"
SRC_URI="mirror://sourceforge/qjackctl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="alsa dbus debug portaudio qt4 +qt5"

REQUIRED_USE="
	^^ ( qt4 qt5 )
"

RDEPEND="
	qt4? ( >=dev-qt/qtcore-4.5:4
		>=dev-qt/qtgui-4.5:4
		dbus? ( >=dev-qt/qtdbus-4.5:4 ) )
	qt5? ( >=dev-qt/qtcore-5.1:5
		>=dev-qt/qtgui-5.1:5
		>=dev-qt/qtwidgets-5.1:5
		>=dev-qt/qtxml-5.1:5
		dbus? ( >=dev-qt/qtdbus-5.1:5 ) )

	>=media-sound/jack-audio-connection-kit-0.109.2
	alsa? ( media-libs/alsa-lib )
	portaudio? ( media-libs/portaudio )"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog README TODO TRANSLATORS"

src_prepare() {
	epatch "${FILESDIR}/${P}-qobject-include.patch"
}

src_configure() {
	local qt_flag=""
	if use qt4; then
		export QT_SELECT=qt4
		export QTVERSION=4
		qt_flag="$(use_with qt4 qt4 $(qt4_get_bindir))"
	elif use qt5; then
		export QT_SELECT=qt5
		export QTVERSION=5
		export PATH="$(qt5_get_bindir):${PATH}"
		qt_flag="$(use_with qt5 qt5 $(qt5_get_bindir))"
		ewarn "Please note that Qt5 support is still experimental."
		ewarn "If you find anything to not work with Qt5, please report a bug."
	fi
	econf \
		${qt_flag} \
		$(use_enable alsa alsa-seq) \
		$(use_enable dbus) \
		$(use_enable debug) \
		$(use_enable portaudio)

	# Emulate what the Makefile does, so that we can get the correct
	# compiler used.
	use qt4 && eqmake4 ${PN}.pro -o ${PN}.mak
	use qt5 && eqmake5 ${PN}.pro -o ${PN}.mak
}

src_compile() {
	emake -f ${PN}.mak
}
