#!/usr/bin/env perl

use strict;
use warnings;

use Test2::V0;
use IPC::System::Simple qw(capturex systemx);
use String::ShellQuote;
use JSON::PP qw(decode_json);

use constant CMD_NAME => 'cmd-wrap-convert-fd-args-to-tmpfile';

my @test_cases = (
	# Test both with and without explicit argument separator
	['--suffix', '.txt', '--suffix', '.yaml', 'git', 'diff', '--word-diff', '--no-index', \'<(ls | shuf)', \'<(ls)'],
	['--suffix', '.txt', '--suffix', '.yaml', '--', 'git', 'diff', '--word-diff', '--no-index', \'<(ls | shuf)', \'<(ls)'],
);

for my $args (@test_cases) {
	# Run the command
	my $quoted =
		join " ",
		map {
			( ! ref $_
			? shell_quote($_)
			: $$_
			)
		} (CMD_NAME, '--dry-run', @$args);

	my $output = capturex( qw(bash), qw(-c), $quoted );
	my $result = decode_json($output);

	is $result, {
		command => [
			'git', 'diff', '--word-diff', '--no-index',
			'[TEMP DIR]/fd__dev_fd_63.txt',
			'[TEMP DIR]/fd__dev_fd_62.yaml'
		]
	}, "Command properly transformed for case: $quoted";
}

done_testing;
