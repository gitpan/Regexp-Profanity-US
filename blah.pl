#!/usr/bin/perl


use FileHandle;

use Regexp::Profanity::US;

use strict;

my $file = shift or die 'must supply file to check';

open B, $file or die $!;

my ($line, $naughty, %counter, %fh);

autoflush STDOUT 1;
autoflush STDERR 1;

$fh{ambiguous} = \*STDOUT;
$fh{definite}  = \*STDERR;


my @tab_array;

sub tab_array {

    @tab_array = ("\t") x 7;

}

sub proc {

    my $string = shift;
    my $degree = shift;

    my ($R, @M) = profane_list($string, $degree);

    scalar @M > 7 and @M = @M[0..6];

    my $i = 0;
    tab_array;
    for (@M) {
	$tab_array[$i] = $M[$i++]
    }

    if ($R) {
	++$counter{$degree};
	$fh{$degree}->print("@tab_array\t$_");
    }

    $R

}

while (<B>) {

    ++$line;

    next if proc($_, 'definite');
    proc($_, 'ambiguous');

}

warn "definite bad:\t$counter{definite}\n";
warn "ambiguous bad:\t$counter{ambiguous}\n";
warn "total lines:\t$line\n";
