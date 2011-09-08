package MyApp::Locale::LanguageExtension::Getopt;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::LanguageExtension
);

with qw(
    MooseX::Getopt
);

__PACKAGE__->meta->make_immutable;

1;
__END__
