package Regexp::Profanity::US;

use 5.006;
use strict;
use warnings;
use Carp qw(confess);

require Exporter;

use Regexp::Any;

#use Data::Dumper;

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
our $VERSION = '1.3';

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

    return (@M);
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
crappy
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

Regexp::Profanity::US - Perl extension for detecting profanity

=head1 SYNOPSIS

  use Regexp::Profanity::US;

  my $degree  = 'definite'; # or 'ambiguous';

  my @profane = profane_list($string, $degree);
  my $profane = profane     ($string, $degree);


=head1 DESCRIPTION

This module provides an API for checking strings for strings containing
various degrees of profanity, per US standards.

=head1 API

=head2 $profane_word = profane($string, $degree)

Check C<$string> for profanity of degree C<$degree>, where
$degree eq 'definite' or $degree eq 'ambiguous'

For positive matches, returns TRUE, with TRUE being the first match in the
string.

For negative matches, FALSE is returned.

=head2 @profane_word = profane_list($string, $degree)

The sub returns a list of all profane words found in C<$string>, or an
empty list if none were found.


=head1 EXPORT

C<profane()> and C<profane_list>

=head1 DEPENDENCIES

L<Regexp::Any|Regexp::Any>

=head1 OTHER

There is another module supporting profanity checking, namely:
L<Regexp::Common::profanity|Regexp::Common::profanity>, but I had 
several issues with making practical use of it:

=over

=item * Many of the profane words were of European origin 

I did not
find them profane at all from an American standpoint. 

=item * I could not easily add profane words to that module

It uses a rotated character set. I would be happy to roll
this into L<Regexp::Common> if possible.



=back


=head1 AUTHOR

T. M. Brannon, tbone@cpan.org

=cut
