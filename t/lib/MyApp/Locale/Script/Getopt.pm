package MyApp::Locale::Script::Getopt;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::Script
);

with qw(
    MooseX::Getopt
);

__PACKAGE__->meta->make_immutable;

1;
__END__
