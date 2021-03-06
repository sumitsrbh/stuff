# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythonmagick/pythonmagick-0.9.8.ebuild,v 1.4 2013/04/23 05:35:51 patrick Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit python-r1

MY_PN="PythonMagick"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python bindings for ImageMagick"
HOMEPAGE="http://www.imagemagick.org/script/api.php"
SRC_URI="http://www.imagemagick.org/download/python/${MY_P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/boost[${PYTHON_USEDEP}]
		media-gfx/imagemagick"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	python_copy_sources
}

src_configure() {
	configuration() {
		sed -e "s/-lboost_python /-lboost_python-${EPYTHON#python} /" -i Makefile.in
		econf
	}
	python_foreach_impl run_in_build_dir configuration
}

src_compile() {
	python_foreach_impl run_in_build_dir default
}

src_install() {
	python_foreach_impl run_in_build_dir default
}
