use strict;
use warnings;

use Test::Requires {
    'Test::DistManifest' => '0',
};

manifest_ok();

__END__

=pod

=head1 NAME

manifest.t - Testing MANIFEST and MANIFEST.SKIP

=head1 NOTES

When making the distribution, MANIFEST.SKIP isn't copied, so check in the
parent directory, which is the actual distribution root, as well.

=cut
