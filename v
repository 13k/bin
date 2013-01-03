#!/usr/bin/env perl

use strict;
use warnings;

my $executable = "vim";
my(@files, @args, $line);

if (scalar(@ARGV) > 0) {
	if ($ARGV[0] =~ /(.*):(\d+)\z/) {
		push @files, $1;
		$line = $2;
	} else {
		push @files, @ARGV
	}
}

if ($line) {
	push @args, "+$line";
	push @args, $files[0];
} else {
	push @args, @files;
}

unshift @args, $executable;

exec @args;
