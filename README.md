# SDSC polymake roll

## Overview

This roll bundles... polymake

For more information about the various packages included in the polymake roll please visit their official web pages: www.polymake.org



## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate polymake source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

boost (sdsc boost roll) gmp,mpfr (sdsc gnucompiler roll)

yum perl packages:

perl-XML-LibXSLT.x86_64
perl-IO-Zlib.x86_64
perl-Term-UI.x86_64
perl-TermReadKey.x86_64



## Building

To build the polymake-roll, execute these instructions on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make default 2>&1 | tee build.log
% grep "RPM build error" build.log
```

If nothing is returned from the grep command then the roll should have been
created as... `polymake-*.iso`. If you built the roll on a Rocks frontend then
proceed to the installation step. If you built the roll on a Rocks development
appliance you need to copy the roll to your Rocks frontend before continuing
with installation.

## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll polymake
% cd /export/rocks/install
% rocks create distro
% rocks run roll polymake | bash
```

In addition to the software itself, the roll installs polymake environment
module files in:

```shell
/opt/modulefiles/applications/polymake
```


## Testing

The polymake-roll includes a test script which can be run to verify proper
installation of the polymake-roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/polymake.t 
```
