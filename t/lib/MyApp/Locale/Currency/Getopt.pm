package MyApp::Locale::Currency::Getopt;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::Currency
);

with qw(
    MooseX::Getopt
);

__PACKAGE__->meta->make_immutable;

1;
__END__
