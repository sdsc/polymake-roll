NAME               = polymake
VERSION            = 2.13.1
RELEASE            = 0
RPM.EXTRAS         = AutoReq:No

SRC_SUBDIR         = polymake

SOURCE_NAME        = $(NAME)
SOURCE_VERSION     = 2.13-1
SOURCE_SUFFIX      = tar.bz2
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_NAME)-$(SOURCE_VERSION)

TAR_BZ2_PKGS           = $(SOURCE_PKG)
