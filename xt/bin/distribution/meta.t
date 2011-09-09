use strict;
use warnings;

use Test::Requires {
    'Test::CPAN::Meta' => '0.12',
};

meta_yaml_ok();

__END__

=pod

=head1 NAME

meta.t - Testing that META.yml in the distribution matches the current specification

=head1 SEE ALSO

=over 4

=item *

L<Test::CPAN::Meta>

=item *

L<Test::YAML::Meta>

=back

=cut
