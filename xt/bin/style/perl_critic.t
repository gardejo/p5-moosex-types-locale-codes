use strict;
use warnings;

use Test::Requires {
    'Perl::Critic'       => '0.094',
    'Test::Perl::Critic' => '0',
};

Test::Perl::Critic->import(
    -profile => 'xt/rc/perl_critic',
);
all_critic_ok();

__END__

=pod

=head1 NAME

perl_critic.t - Testing that modules complies with Perl::Critic

=head1 SEE ALSO

=over 4

=item *

L<Test::Perl::Critic>

=item *

L<Perl::Critic>

=item *

F<xt/rc/perl_critic>

=back

=cut
