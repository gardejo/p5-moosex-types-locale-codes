package MyApp::Locale::Language::Getopt;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::Language
);

with qw(
    MooseX::Getopt
);

__PACKAGE__->meta->make_immutable;

1;
__END__
