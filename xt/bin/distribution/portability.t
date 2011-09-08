use strict;
use warnings;

use Test::Requires {
    'Test::Portability::Files' => '0',
};

options(
    all_tests          => 0,
    test_amiga_length  => 1,
    test_ansi_chars    => 1,
    test_case          => 1,
    test_dir_noext     => 1,
    test_dos_length    => 0,
    test_mac_length    => 0,
    test_one_dot       => 1,
    test_space         => 1,
    test_special_chars => 1,
    test_symlink       => 1,
    test_vms_length    => 1,
);

run_tests();

__END__

=pod

=head1 NAME

portability.t - Testing file names portability

=head1 SEE ALSO

=over 4

=item *

L<Test::Portability::Files>

=back

=cut
