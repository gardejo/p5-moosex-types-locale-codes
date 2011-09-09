use strict;
use warnings;

use Test::Requires {
    'Test::Spelling' => '0',
};

use IO::File;

my $handle_of_stop_words = IO::File->new('xt/rc/stop_words', 'r');
add_stopwords(
    grep {
        $_ =~ m{ \A [^#] }xms;
    } map {
        chomp $_;
        $_;
    } (<$handle_of_stop_words>)
);

all_pod_files_spelling_ok();

__END__

=pod

=head1 NAME

spelling.t - Testing POD spelling of all modules

=head1 NOTES

=head2 How To Install I<GNU Aspell> and English Dictionary

For example:

    % sudo aptitude update && sudo aptitude install aspell aspell-en

=head1 SEE ALSO

=over 4

=item *

L<Test::Spelling>

=item *

L<http://blog.livedoor.jp/xaicron/archives/51286157.html>

=item *

F<xt/rc/stop_words>

=back

=cut
