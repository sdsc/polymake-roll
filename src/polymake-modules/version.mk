NAME        = polymake-modules
RELEASE     = 1
PKGROOT     = /opt/modulefiles/applications/polymake

VERSION_SRC = $(REDHAT.ROOT)/src/polymake/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
