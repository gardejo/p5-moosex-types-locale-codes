package MyApp::Locale::LanguageFamily::Getopt;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::LanguageFamily
);

with qw(
    MooseX::Getopt
);

__PACKAGE__->meta->make_immutable;

1;
__END__
