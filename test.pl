# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 3 };
use Regexp::Profanity::US;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.


my $string = 'fuck off you shitty ass bitch';

my $degree = 'definite';

my ($R, @R) = profane_list($string, $degree);

ok (@R, 2);

use Data::Dumper;

$degree = 'ambiguous';

my ($R, @R) = profane_list($string, $degree);

ok (@R, 1);

#die Dumper(\@R);

