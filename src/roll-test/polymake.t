#!/usr/bin/perl -w
# polymake roll installation test.  Usage:
# polymake.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/polymake';

my $TESTFILE = 'tmppolymake';

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
module load polymake
polymake --help
END
close(OUT);

# polymake-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'polymake installed');
} else {
  ok(! $isInstalled, 'polymake not installed');
}

SKIP: {
  skip 'polymake not installed', 4 if ! $isInstalled;
  $output = `bash $TESTFILE.sh 2>&1`;
  ok($output =~ /usage: polymake/, 'polymake runs');
  `/bin/ls /opt/modulefiles/applications/polymake/[0-9.]* 2>&1`;
  ok($? == 0, 'polymake module installed');
  `/bin/ls /opt/modulefiles/applications/polymake/.version.[0-9.]* 2>&1`;
  ok($? == 0, 'polymake version module installed');
  ok(-l '/opt/modulefiles/applications/polymake/.version',
     'polymake version module link created');
}

`rm -f $TESTFILE*`;
