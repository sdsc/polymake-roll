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
PKGROOT = /opt/polymake

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include pull.mk

COMPILERSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module load gnu || true; \
    module load boost || true; \
  fi; \
  echo === Compiler and version ===; \
  gcc --version; \
  echo === BOOSTHOME ===; \
  echo $${BOOSTHOME} \

build: $(SRC_DIRS)
	# An author's name containing an umlaut causes javac failures.  There's
	# probably a better way to handle it than stripping the author lines.
	perl -pi -e '$$_ = "" if $$_ =~ /@author.*Thilo/' \
	  `find $(SOURCE_DIR) -name '*.java'`
	( \
	  cd $(SOURCE_DIR); \
	  $(COMPILERSETUP); \
	  case `which gcc` in \
	    */gcc/*/gcc) \
	      GNUHOME=`which gcc | sed 's/\/gcc.*//'`;; \
	    *) \
	      GNUHOME=`which gcc | sed 's/\/[^\/]*\/gcc$//'`;; \
	  esac; \
	  GMPHOME=`find $${GNUHOME} -name gmp.h -print -quit | sed 's#/include/gmp.h##'`; \
	  MPFRHOME=`find $${GNUHOME} -name mpfr.h -print -quit | sed 's#/include/mpfr.h##'`; \
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
	  echo ./configure --prefix=$(ROOT)/$(PKGROOT) $${confSwitches}; \
	  export CXXFLAGS="-march=x86-64"; \
	  ./configure --prefix=$(PKGROOT) $${confSwitches}; \
	  $(MAKE) \
	)
	@echo "::: Package $(NAME) build complete :::"
	
install::
	# Using a bind mount appears to be the only way to prevent the build
	# from incorporating $(ROOT) in binary files.
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	-mkdir -p -m 755 $(PKGROOT)
	mount --bind $(ROOT)/$(PKGROOT) $(PKGROOT)
	( \
	  cd $(SOURCE_DIR); \
	  $(MAKE) install \
	)
	umount $(PKGROOT)
	-rmdir -p $(PKGROOT)
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR)
