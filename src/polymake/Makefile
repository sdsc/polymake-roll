# $Id$
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 5.6 (Emerald Boa)
# 		         version 6.1 (Emerald Boa)
# 
# Copyright (c) 2000 - 2013 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log$

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

DESCRIBE_MPFR = echo built with mpfr $(call GET_MODULE_VERSION, mpfr)
MODULE_LOAD_MPFR = $(call MODULE_LOAD_PACKAGE, mpfr, MPFRHOME)

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	# Compilation fails w/gnu v7 compilers, so use the system gnu
	if test "$(COMPILERNAME)" != "gnu"; then \
	  $(MODULE_LOAD_CC); \
	fi; \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC); \
	  $(DESCRIBE_GMP); \
	  $(DESCRIBE_MPFR); \
	  $(DESCRIBE_BOOST) \
	) > $@

LICENSE: $(SRC_DIRS)
	cp license-files/COPYING $(SOURCE_DIR)/
	$(CHECK_LICENSE_FILES)
	echo GPL > $@

build: $(SRC_DIRS)
	# An author's name containing an umlaut causes javac failures.  There's
	# probably a better way to handle it than stripping the author lines.
	perl -pi -e '$$_ = "" if $$_ =~ /@author.*Thilo/' \
	  `find $(SOURCE_DIR) -name '*.java'`
	( \
	  cd $(SOURCE_DIR); \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_GMP); \
	  $(MODULE_LOAD_MPFR); \
	  $(MODULE_LOAD_BOOST); \
	  confSwitches=""; \
	  if test -n "$${BOOSTHOME}"; then \
	    confSwitches="$${confSwitches} --with-boost=$${BOOSTHOME}"; \
	  fi; \
	  if test -n "$${GMPHOME}"; then \
	    confSwitches="$${confSwitches} --with-gmp=$${GMPHOME}"; \
	  fi; \
	  if test -n "$${MPFRHOME}"; then \
	    confSwitches="$${confSwitches} --with-mpfr=$${MPFRHOME}"; \
	  fi; \
	  if test "$(COMPILERNAME)" = "gnu"; then \
	    module unload gnu; \
	  fi; \
	  echo ./configure --prefix=$(ROOT)/$(PKGROOT) $${confSwitches}; \
	  export CXXFLAGS="-std=c++98 -march=x86-64"; \
	  ./configure --prefix=$(PKGROOT) $${confSwitches}; \
	  $(MAKE) \
	)
	@echo "::: Package $(NAME) build complete :::"
	
install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	# Using a bind mount appears to be the only way to prevent the build
	# from incorporating $(ROOT) in binary files.
	$(PKGROOT_BIND_MOUNT)
	( \
	  cd $(SOURCE_DIR); \
	  $(MAKE) install \
	)
	$(PKGROOT_BIND_UMOUNT)
	$(INSTALL_LICENSE_FILES)
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR) DESCRIPTION LICENSE
