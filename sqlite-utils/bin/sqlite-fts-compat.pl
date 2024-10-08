#!/usr/bin/env perl
# SPDX-License-Identifier: CC0-1.0

use strict;
use warnings;

use DBI;
use DBD::SQLite ();

my $dbh = DBI->connect("dbi:SQLite:dbname=:memory:", "", "", { RaiseError => 1 });

my @fts_versions = qw(fts5 fts4 fts3);
my $supported_fts;

for my $fts (@fts_versions) {
	eval {
		$dbh->do("CREATE VIRTUAL TABLE temp.$fts USING $fts(content)");
		$supported_fts = $fts;
		$dbh->do("DROP TABLE temp.$fts");
	};
	last if $supported_fts;
}

if ($supported_fts) {
	print "The most advanced supported FTS version is: $supported_fts\n";
} else {
	print "No FTS support found\n";
}

$dbh->disconnect;
