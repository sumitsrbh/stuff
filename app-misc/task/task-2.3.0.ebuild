# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/task/task-2.2.0.ebuild,v 1.2 2013/08/14 16:10:20 grobian Exp $

EAPI=5

inherit eutils cmake-utils bash-completion-r1

DESCRIPTION="Taskwarrior is a command-line todo list manager"
HOMEPAGE="http://taskwarrior.org/projects/show/taskwarrior/"
MY_P="${PN}-${PV/_/.}"
SRC_URI="http://taskwarrior.org/download/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos ~arm"
IUSE="vim-syntax zsh-completion"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	# use the correct directory locations
	sed -i -e "s:/usr/local/share/doc/task/rc:${EPREFIX}/usr/share/task/rc:" \
		doc/man/taskrc.5.in doc/man/task-tutorial.5.in doc/man/task-color.5.in || die
	sed -i -e "s:/usr/local/bin:${EPREFIX}/usr/bin:" \
		doc/man/task-faq.5.in scripts/add-ons/* || die

	# don't automatically install scripts
	sed -i -e '/scripts/d' CMakeLists.txt || die
}

src_configure() {
	mycmakeargs=(
		-DTASK_DOCDIR="${EPREFIX}"/usr/share/doc/${PF}
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newbashcomp scripts/bash/task.sh task

	if use vim-syntax ; then
		rm scripts/vim/README
		insinto /usr/share/vim/vimfiles
		doins -r scripts/vim/*
	fi

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins scripts/zsh/*
	fi

	exeinto /usr/share/${PN}/scripts
	doexe scripts/add-ons/*
}
