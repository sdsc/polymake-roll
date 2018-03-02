# SDSC polymake roll

## Overview

This roll bundles the polymake geometry application.

For more information about the various packages included in the polymake roll please visit their official web pages: www.polymake.org


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate polymake source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

yum install perl-ExtUtils-Embed

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.

The roll sources assume that modulefiles provided by SDSC compiler
rolls are available, but it will build without them as long as the environment
variables they provide are otherwise defined.

The build process requires the GMP, MPFR, and BOOST libraries and assumes that
the modulefiles provided by the SDSC boost-roll and gnucompiler-roll are available.  It will build without
the modulefiles as long as the environment variables they provide are otherwise
defined.


## Building

To build the polymake-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `polymake-*.disk1.iso`.  If you built the
roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.

This roll source supports building with different compilers.
The `ROLLCOMPILER` make variable can be used to
specify the names of compiler modulefiles to use for building the
software, e.g.,

```shell
% make ROLLCOMPILER=intel 2>&1 | tee build.log
```

The build process recognizes "gnu", "intel" or "pgi" as the value for the
`ROLLCOMPILER` variable.  The default value is "gnu".


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll polymake
% cd /export/rocks/install
% rocks create distro
```

Subsequent installs of compute and login nodes will then include the contents
of the polymake-roll.  To avoid cluttering the cluster frontend with unused
software, the polymake-roll is configured to install only on compute and
login nodes. To force installation on your frontend, run this command after
adding the polymake-roll to your distro

```shell
% rocks run roll polymake host=NAME | bash
```

where NAME is the DNS name of a compute or login node in your cluster.

In addition to the software itself, the roll installs polymake environment
module files in:

```shell
/opt/modulefiles/applications/polymake
```


## Testing

The polymake-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/polymake.t 
```
