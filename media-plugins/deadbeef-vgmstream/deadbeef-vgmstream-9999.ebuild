# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: media-sound/deadbeef-infobar/deadbeef-infobar-9999.ebuild,v 1 2014/03/03 21:35:34 megabaks Exp $

EAPI="5"

inherit eutils git-2

DESCRIPTION="A DeaDBeeF plugin for playing streaming video game music using vgmstream."
HOMEPAGE="https://github.com/johnwchadwick/deadbeef-vgmstream"
EGIT_REPO_URI="git://github.com/johnwchadwick/${PN}.git"

LICENSE="vgmstream"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND_COMMON="
	media-sound/deadbeef
	media-libs/libvorbis
	media-sound/mpg123"

RDEPEND="${DEPEND_COMMON}"
DEPEND="${DEPEND_COMMON}"

src_prepare(){
	sed \
		-e "s|-I\$(DEADBEEF_ROOT)/include|-I/usr/include/deadbeef|" \
		-e "s|-I\$(DEADBEEF_ROOT)/lib|-I/usr/$(get_libdir)/deadbeef|" \
		-i Makefile || die "sed fail"
}

src_install(){
	insinto /usr/$(get_libdir)/deadbeef
	doins vgm.so
	dodoc COPYING
}
