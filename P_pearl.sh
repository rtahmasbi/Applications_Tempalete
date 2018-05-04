

cat > out_lines.pl
#!/usr/bin/perl
use strict;
use warnings;
my %patterns;
my $srch;

# Open file and get patterns to search for
open(my $fh2,"<","file2")|| die "ERROR: Could not open file2";
while (<$fh2>)
{
chop;
$patterns{$_}=1;
}

# Now read data file
open(my $fh1,"<","file1")|| die "ERROR: Could not open file1";
while (<$fh1>)
{
(undef,$srch,undef)=split;
print $_ if defined $patterns{$srch};
}



############
out_lines file1 file2
############
