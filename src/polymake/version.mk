ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME           = sdsc-polymake
VERSION        = 2.14
RELEASE        = 3
PKGROOT        = /opt/polymake

SRC_SUBDIR     = polymake

SOURCE_NAME    = polymake
SOURCE_SUFFIX  = tar.bz2
SOURCE_VERSION = 2.14
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_NAME)-$(SOURCE_VERSION)

TAR_BZ2_PKGS   = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
