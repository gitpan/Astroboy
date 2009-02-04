package Astroboy::Base;
use strict;
use vars qw(@ISA $VERSION @EXPORT);
use Exporter;
@ISA = qw/Exporter/;
@EXPORT = qw(debug abs_music artists artists_count artist_guess);
use LEOCHARRE::Dir;
use LEOCHARRE::Class2;
use Carp;
no strict 'refs';

__PACKAGE__->make_count_for('artists');
$Astroboy::ABS_MUSIC ||=  $ENV{HOME}.'/music';

$VERSION = sprintf "%d.%02d", q$Revision: 1.6 $ =~ /(\d+)/g;

sub debug { $Astroboy::DEBUG and print STDERR "@_"; 1 }

sub abs_music { $Astroboy::ABS_MUSIC ||=  $ENV{HOME}.'/music' }

 
sub artists {
   my $self = shift;

   unless( $self->{artists} ){
      
      my @a = sort (  LEOCHARRE::Dir::lsd( abs_music() ) );
      $self->{artists} = [@a];
   }
   $self->{artists};
}




sub artist_guess {
   my ($self,$path) = ($_[0],lc($_[1]));


   unless($self->{artists_match}){
      my $artists = $self->artists;
      for (@$artists){
         my $a = lc ($_);
         $a=~s/_+/ /g;
         $a=~s/^\s+|\s+$//g;
         $self->{artists_match}->{$a}++;
      }      
   }


   # just return first match
   for my $artist ( keys %{$self->{artists_match}}  ){
      
      $path=~/\b$artist\b/ or next;
      return $artist;
   }
   
   return;
}


1;

__END__

=pod

=head1 NAME

Astroboy::Base

=head1 DESCRIPTION

Private.

=head1 METHODS

=head2 artists()

Simply returns names of subdirs in ABS_MUSIC

=head2 artist_guess()

Argument is a string, a filename, or a path.
Tries to guess what artist it is.
Uses artists currently listed in ABS MUSIC.

=head2 abs_music()

=head2 debug()

=head1 CAVEATS

This package is in development.
Do not interface with the api directly. 
Use the command line interface scripts for stability.

=head1 SEE ALSO

L<Astroboy>

=head1 AUTHOR

Leo Charre leocharre at cpan dot org

=head1 LICENSE

This package is free software; you can redistribute it and/or modify it under the same terms as Perl itself, i.e., under the terms of the "Artistic License" or the "GNU General Public License".

=head1 DISCLAIMER

This package is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the "GNU General Public License" for more details.

=cut

