use strict;
use warnings;

use Test::Requires {
    'Test::Kwalitee' => '0',
};

my $file = 'Debian_CPANTS.txt';
if (-e $file) {
    unlink $file
        or die "Could not unlink $file: $!\n";
}

__END__

=pod

=head1 NAME

kwalitee.t - Testing that distribution complies with a kwalitee gauge

=head1 SEE ALSO

=over 4

=item *

L<Test::Kwalitee>

=back

=cut
