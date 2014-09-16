NAME           = polymake
VERSION        = 2.13.1
RELEASE        = 1
PKGROOT        = /opt/polymake

SRC_SUBDIR     = polymake

SOURCE_NAME    = $(NAME)
SOURCE_SUFFIX  = tar.bz2
SOURCE_VERSION = 2.13-1
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_NAME)-$(SOURCE_VERSION)

TAR_BZ2_PKGS   = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
