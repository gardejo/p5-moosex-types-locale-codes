package MyApp::Locale::LanguageVariation::Getopt;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::LanguageVariation
);

with qw(
    MooseX::Getopt
);

__PACKAGE__->meta->make_immutable;

1;
__END__
