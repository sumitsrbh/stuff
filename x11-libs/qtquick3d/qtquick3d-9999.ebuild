# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/arora/arora-0.11.0.ebuild,v 1.2 2011/01/26 16:20:15 darkside Exp $

EAPI=3
inherit eutils qt4-r2 git-2

MY_P="qt3d"

DESCRIPTION="Qt3D binding for qml"
HOMEPAGE="http://labs.qt.nokia.com/2011/05/20/qt-quick-3d-downloads-available/"
EGIT_REPO_URI="git://gitorious.org/qt-labs/${MY_P}.git"

LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="0"
KEYWORDS=""
IUSE="debug doc"

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-opengl-qt3d:4
	x11-libs/qt-sql:4
	x11-libs/qt-webkit:4
	x11-libs/qt-xmlpatterns:4"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}"/"${MY_P}"

src_configure() {
	eqmake4 CONFIG+=package PREFIX="${EPREFIX}"/usr
}
