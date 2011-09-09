use strict;
use warnings;

use Test::Requires {
    'Test::CheckChanges' => '0',
};

ok_changes(base => '../..');

__END__

=pod

=head1 NAME

changes.t - Testing change log in the distribution

=head1 SEE ALSO

=over 4

=item *

L<Test::CheckChanges>

=back

=cut
