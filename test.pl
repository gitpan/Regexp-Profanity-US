# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 5 };
use Regexp::Profanity::US;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.


my $string = 'fuck off you shitty ass Python-using bitch';

my $degree = 'definite';

my @R = profane_list($string, $degree);

ok (@R, 3);

use Data::Dumper;

$degree = 'ambiguous';

my @R = profane_list($string, $degree);

ok (@R, 1);

#die Dumper(\@R);

$string = 'Every good boy does fine';

$R = profane($string, 'definite');

ok ($R, 0);

$string = 'Java is a language for punk pussy-ass muthafuckas';

$R = profane($string, 'definite');

ok ($R, 'pussy-ass');
