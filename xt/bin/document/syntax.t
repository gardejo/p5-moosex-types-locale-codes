use strict;
use warnings;

use Test::Requires {
    'Test::Pod' => '1.40',
};

eval {
    require 'Test::Pod';    # a bad know-how: to pass Test::Kwalitee
};

all_pod_files_ok( all_pod_files(qw(lib)) );

__END__

=pod

=head1 NAME

syntax.t - Testing POD syntax of all modules

=head1 SEE ALSO

=over 4

=item *

L<Test::Pod>

=back

=cut
