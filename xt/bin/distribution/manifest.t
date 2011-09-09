use strict;
use warnings;

use Test::Requires {
    'Test::DistManifest' => '0',
};

manifest_ok();

__END__

=pod

=head1 NAME

manifest.t - Testing MANIFEST and MANIFEST.SKIP in the distribution

=head1 NOTES

When making the distribution, F<MANIFEST.SKIP> isn't copied, so check in the
parent directory, which is the actual distribution root, as well.

=cut
