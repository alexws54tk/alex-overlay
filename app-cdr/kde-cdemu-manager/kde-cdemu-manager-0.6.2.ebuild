# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5

DESCRIPTION="CDEmu manager front end for KF5"
HOMEPAGE="https://github.com/Real-Gecko/KDE-CDEmu"
SRC_URI="http://gpo.ws54.tk/gentoo-distfiles/${P}.tar.xz"

RESTRICT="mirror"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+qt5"
REQUIRED_USE="qt5"

RDEPEND="
	app-cdr/cdemu-daemon
	dev-qt/qtwidgets:5
	kde-frameworks/kconfigwidgets
	kde-frameworks/kcoreaddons
	kde-frameworks/kdbusaddons
	kde-frameworks/ki18n
	kde-frameworks/knotifications
	kde-frameworks/kwidgetsaddons
	kde-frameworks/kxmlgui
"
DEPEND="${RDEPEND}
	dev-lang/python
	kde-frameworks/extra-cmake-modules
	kde-frameworks/kdoctools
"

#S="${WORKDIR}/${MY_PN}-${PV}"

DOCS=(ChangeLog.md README.md)
