# SDSC polymake roll

## Rocks and CentOS Version Support Change

> ** IMPORTANT NOTICE **
>
> The head of the master branch of this repository no longer supports build
> and install on Rocks/CentOS 6 and only supports Rocks/CentOS 7 
> (see the Dependencies section for more details). The last
> supported commit of this repository for Rocks/CentOS 6 is 2539bab
> which is tagged as last\_centos6.
>
> If/when building this roll for Rocks/CentOS 6 you **must** checkout the
> last\_centos6 tag and build from there. If you need to make custom
> changes to the roll source for Rocks/CentOS 6 you should fork this repository
> and create your own branch from the 
> last\_centos6 tag.

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

yum install perl-ExtUtils-Embed<br>
yum install perl-XML-Writer

Note that this version of polymake (3.1) requires a later version of perl (5.16) then is provided by centos 6 (5.10). The commit that represents the latest commit that can be used with centos 6 is tagged "last_centos"

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
