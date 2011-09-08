use strict;
use warnings;

use Test::Requires {
    '5.010_001'                    => undef,
    'Data::Validator'              => '0',
    'MooseX::Getopt'               => '0',
    'MooseX::Types::LoadableClass' => '0',
    'Test::UseAllModules'          => '0.12',
};

use Test::More;
use Test::NoWarnings;

Test::UseAllModules->import(
    under => (
        'lib',   # Implicit
        't/lib', # Explicit
    ),
);

plan tests => Test::UseAllModules::_get_module_list() + 1;

all_uses_ok();

__END__

=pod

=head1 NAME

load.t - Testing compilation of all manifested modules (include test modules)

=head1 SEE ALSO

=over 4

=item *

L<Test::UseAllModules>

=item *

L<Test::LoadAllModules>

=item *

L<Test::Compile>

=back

=cut
