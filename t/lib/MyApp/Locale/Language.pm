package MyApp::Locale::Language;

use namespace::autoclean;

use Moose;

use MooseX::Types::Locale::Codes::Language qw(
    LanguageCode
    LanguageName
);

has 'code' => (
    isa         => LanguageCode['alpha2'],
        # same as : isa => LanguageCode
    is          => 'rw',
);

has 'name' => (
    isa         => LanguageName['alpha2'],
        # same as : isa => LanguageName
    is          => 'rw',
);

__PACKAGE__->meta->make_immutable;

1;
__END__
