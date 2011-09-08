use strict;
use warnings;

use Test::Requires {
    'Test::Pod::Coverage' => '0.08',
};

eval {
    require 'Test::Pod::Coverage';  # a bad know-how: to pass Test::Kwalitee
};

all_pod_coverage_ok(
    {
        also_private => [qw(
            BUILDARGS
            BUILD
            DEMOLISH
        )],
    },
);

__END__

=pod

=head1 NAME

coverage.t - Testing coverage of documentation

=head1 NOTES

Is L<Test::Pod::Coverage> incompatible with L<Devel::Cover> and
L<Attribute::Protected>?

=head1 SEE ALSO

=over 4

=item *

L<Test::Pod::Coverage>

=back

=cut
