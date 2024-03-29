use strict;
use warnings;

use Test::Requires {
    'Test::NoTabs' => '0',
};

all_perl_files_ok('lib');

__END__

=pod

=head1 NAME

tabs.t - Testing presence of tabs of all modules

=head1 NOTES

C<< all_perl_files_ok() >> is bad because C<< inc/ModuleInstall/* >> will die.

=head1 SEE ALSO

=over 4

=item *

L<Test::NoTabs>

=back

=cut
