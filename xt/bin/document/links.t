use strict;
use warnings;

use Test::Requires {
    'Test::Pod::LinkCheck' => '0',
};

Test::Pod::LinkCheck->new(
    check_cpan   => 1,      # default
    cpan_backend => 'CPAN', # neither 'CPANPLUS' nor 'CPANSQLite'
)->all_pod_ok;

__END__

=pod

=head1 NAME

links.t - Testing presence of invalid links in POD of all modules

=head1 NOTES

=head2 Probably we initialize any CPAN client before the testing

For example,

    % cpan
    cpan> reload index
    cpan> exit

or, if you use L<CPAN::Mini>,

    % cpan
    cpan> o conf urllist unshift file:///path/to/minicpan
    cpan> o conf commit
    cpan> reload index
    cpan> exit

=head1 SEE ALSO

=over 4

=item *

L<Test::Pod::LinkCheck>

=item *

L<CPAN>

=item *

L<CPANPLUS>

=item *

L<CPAN::SQLite>

=item *

L<Test::Pod::No404s>

=back

=cut
