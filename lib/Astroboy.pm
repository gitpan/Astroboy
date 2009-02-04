package Astroboy;
use strict;
use Astroboy::AlbumFile;
use Astroboy::AlbumDir;
use Astroboy::Base;
use vars qw($VERSION); $VERSION = sprintf "%d.%02d", q$Revision: 1.5 $ =~ /(\d+)/g;
no strict 'refs';
use LEOCHARRE::Class2;
__PACKAGE__->make_accessor_setget('errstr');
sub new { return __PACKAGE__ }

sub file { 
   my ($self,$_path) = @_;
   my $abs = Cwd::abs_path($_path) or die;
   -f $abs or die;
   ($self->{file}->{$abs} ||= Astroboy::AlbumFile->new( $abs )) or die;
}

sub dir { 
   my ($self,$_path) = @_;
   my $abs = Cwd::abs_path($_path) or die;
   -d $abs or die;
   ($self->{dir}->{$abs} ||= Astroboy::AlbumDir->new( $abs )) 
      or $self->errstr("not album?")
      and return;
}






# make this a singleton
#
#
#

1;

__END__

=pod

=head1 NAME

Astroboy - organize mp3s on disk by id3 tags

=head1 DESCRIPTION

Astroboy is meant to be used via the command line.
See L<astroboy>.

=head1 API

=head2 new()

=head2 dir()

Argument is path to directory.
Returns Astroboy::AlbumDir object.

=head2 file()

Argument is path to file, returns Astroboy::AlbumFile object.

=head2 errstr()


=head1 INHERITED FROM Astroboy::Base

=head2 artists()

=head2 debug()

=head2 abs_music


=head1 CAVEATS

Do not use the api, use the cli.
In development. Contact L<AUTHOR> for suggestions, concerns, etc.

=head1 AUTHOR

Leo Charre leocharre at cpan dot org

=head1 LICENSE

This package is free software; you can redistribute it and/or modify it under the same terms as Perl itself, i.e., under the terms of the "Artistic License" or the "GNU General Public License".

=head1 DISCLAIMER

This package is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the "GNU General Public License" for more details.

=cut

