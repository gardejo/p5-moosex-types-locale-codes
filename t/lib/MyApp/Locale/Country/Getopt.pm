package MyApp::Locale::Country::Getopt;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::Country
);

with qw(
    MooseX::Getopt
);

__PACKAGE__->meta->make_immutable;

1;
__END__
