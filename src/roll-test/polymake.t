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

# polymake-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'polymake installed');
} else {
  ok(! $isInstalled, 'polymake not installed');
}

SKIP: {
  skip 'polymake not installed', 1 if ! -d '/opt/polymake';
  $output = `. /etc/profile.d/modules.sh;module load polymake;polymake --help 2>&1`;
  ok($output =~ /usage: polymake \[options\] \[arguments\]/, 'polymake works');
}
