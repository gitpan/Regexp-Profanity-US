package Regexp::Profanity::US;

use 5.006;
use strict;
use warnings;
use Carp qw(confess);

require Exporter;

use Regexp::Any;

use Data::Dumper;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Regexp::Profanity::US ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(profane profane_list
);
our $VERSION = '0.9';

our $re_opt = "i";

our @definite;
our @ambiguous;

our %list =
  (
   definite  => \@definite,
   ambiguous => \@ambiguous
  );



# Preloaded methods go here.

sub profane {

    my $word   = shift or confess 'must supply word to match';
    my $degree = shift or confess 'must supply degree of profanity';

    my $re   = match_any_and_capture($list{$degree}, $re_opt);

    if ($word =~ /($re)/) {
	return ($1);
    }  else {
	return (0);
    }
}


sub profane_re {

    my ($degree) = shift;

    defined $list{$degree} or die 
      "No profanity list of degree $degree exists";

    match_any_and_capture($list{$degree}, $re_opt);

}

sub profane_list {

    my $word   = shift or confess 'must supply word to match';
    my $degree = shift or confess 'must supply degree of profanity';

    defined $list{$degree} or die 
      "No profanity list of degree $degree exists";


    my @M;

    my $re = profane_re($degree);

    while ($word =~ /($re)/g) {
	push (@M, $1);
    }

    return (scalar @M, @M);
}


BEGIN {
    @definite = qw(

asshole
bitch
bull-shit
bull-shits
bull-shitted
bull-shitter
bull-shitters
bull-shitting
bullshit
bullshits
bullshitted
bullshitter
bullshitters
bullshitting
cock-sucker
cocksucker
cock-sucker
cock-suckers
cock-sucking
cocksucker
cocksuckers
cocksucking
cocksucking
crappy
dick-head
dickhead
fuck
fucked
fucking
fucks
handjob
mother-fucker
mother-fuckers
mother-fucking
motherfucker
motherfuckers
motherfucking
mutha-fucka
mutha-fucka
mutha-fucka
mutha-fucker
mutha-fuckers
mutha-fucking
muthafucka
muthafucka
muthafucka
muthafucker
muthafuckers
muthafucking
muther-fucker
muther-fuckers
muther-fucking
mutherfucker
mutherfuckers
mutherfucking
nigga
nigger
nigguh
punk-ass
punkass
pussy-ass
pussy_ass
pussy\s*ass
faggot
eat-shit
eat\s*shit
suck-my-cock
suckmycock
suck-cock
suckcock
shithead
shit-head
shit_head
shitter
\bshit\b
\bcock\b
\bass\b
\bpussy\b
turdhead
\bturd\b
\bturds\b



);


    @ambiguous = qw(

arse
arsing
ass-hole
ass-holes
assed
asshole
assholes
assing
ball
balled
baller
ballers
balling
balls
bastard
bloody
blowjob
blowjobs
bone
boner
boners
bones
boning
bugger
cock
cocks
coon
crap
crapped
crapper
crappers
crapping
craps
crotch
cuming
cumming
cums
cunt
cunts
dick
dicked
dicking
dickless
dicks
dong
dongs
fart
farted
farter
farting
farts
farty
feltch
feltched
feltcher
feltchers
feltches
feltching
half-arsed
half-assed
halfarsed
halfassed
hard-on
hardon
hump
humped
humper
humpers
humping
humps
piss
piss-take
pissed
pisser
pissers
pisses
pissing
pisstake
pissy
pork
prick
pricks
pronk
pussies
pussy
quim
quims
screw
screwed
screwing
screws
shag
shagged
shagger
shaggers
shagging
shags
shit
shite
shited
shiter
shiters
shites
shitey
shiting
shits
shitted
shitter
shitters
shitting
shitty
spunk
suck
tit
tits
turd
turds
twat
twats
wank
wanked
wanker
wankers
wanking
wanks


)

}

1;


__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Regexp::Profanity::US - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Regexp::Profanity::US;
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


=head1 DESCRIPTION

This module provides an API for checking strings for strings containing
various degrees of profanity, per US standards.

=head1 API

=head2 $retval = profane($string, $degree)

Check C<$string> for profanity of degree C<$degree>, where
$degree eq 'definite' or $degree eq 'ambiguous'

For positive matches, returns TRUE, with TRUE being the first match in the
string.

For negative matches, FALSE is returned.

=head2 ($retval, @profane_words) = profane_list($string, $degree)

Same arguments. The sub returns:

for positive matches, returns TRUE and all profane matches in a list, meaning

 (scalar @M, @M).

for negative matches, return FALSE.



=head1 EXPORT

C<profane()> and C<profane_list>

=head1 DEPENDENCIES

L<Regexp::Match::Any|Regexp::Match::Any> - by Scott McWhirter 
from CPAN but modified locally with patches submitted
to author. Version 0.04 or higher is required.

=head1 OTHER

There is another module supporting profanity checking, namely:
L<Regexp::Common::profanity|Regexp::Common::profanity>, but I had 
several issues with making practical use of it:

=over

=item Many of the profane words were of European origin and I did not
find them profane at all from an American standpoint. 

=item I could not easily add profane words to that module. Without question,
Abigail is a regular expression genius bar none, the edit cycle to use 
the module would have required emailing him the changes. To make local changes
for immediate use would have required doing character rotation on the 
characters first.



=back


=head1 AUTHOR

T. M. Brannon

=cut
