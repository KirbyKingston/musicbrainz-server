package MusicBrainz::Server::Action::ArtistPage;

use strict;
use warnings;
use base 'Catalyst::Action';

use MusicBrainz::Server::Artist;
use MusicBrainz;

=head1 NAME

MusicBrainz::Server::Action::ArtistPage - Custom Action for creating artist pages.

=head1 DESCRIPTION

This fills the Catalyst stash with variables to display the Artist header on a page

=head1 METHODS

=head2 execute

Executes the ArtistPage Action after the action has completed. This will load the artist with a
given MBID into the stash in the {_artist} key. 

=cut

sub execute
{
    my $self = shift;
    my ($controller, $c) = @_;

    my $mbid = $c->request->arguments->[0];
    if (defined $mbid)
    {
        my $mb = $c->mb;
        my $artist = MusicBrainz::Server::Artist->new($mb->{DBH});

        # Validate the arguments
        unless(MusicBrainz::Server::Validation::IsGUID($mbid))
        {
            if (MusicBrainz::Server::Validation::IsNonNegInteger($mbid))
            {
                # Appears to be a row ID
                $artist->SetId($mbid);
            }
            else
            {
                die "Not a valid GUID or row ID";
            }
        }
        else
        {
            # Looks like a GUID
            $artist->SetMBId($mbid);
        }

        $artist->LoadFromId(1)
            or die "Failed to load artist";

        die "You cannot view the special DELETED_ARTIST"
            if ($artist->GetId == ModDefs::DARTIST_ID);

        $c->stash->{_artist} = $artist;
        $c->stash->{artist} = $artist->ExportStash qw( name mbid type date quality resolution );
    }

    $self->NEXT::execute(@_);
}

1;
