use strict;
use warnings;

use Test::Requires {
    'Test::MinimumVersion' => '0',
};

all_minimum_version_ok(
    5.008_001,
    {
        paths => [('lib')],
    },
);

__END__

=pod

=head1 NAME

has_version.t - Testing version numbers

=head1 SEE ALSO

=over 4

=item *

L<Test::HasVersion>

=back

=cut
