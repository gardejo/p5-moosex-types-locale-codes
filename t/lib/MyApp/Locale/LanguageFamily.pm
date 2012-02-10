package MyApp::Locale::LanguageFamily;

use namespace::autoclean;

use Moose;

use MooseX::Types::Locale::Codes::LanguageFamily qw(
    LanguageFamilyCode
    LanguageFamilyName
);

has 'code' => (
    isa         => LanguageFamilyCode['alpha'],
        # same as : isa => LanguageFamilyCode
    is          => 'rw',
);

has 'name' => (
    isa         => LanguageFamilyName['alpha'],
        # same as : isa => LanguageFamilyName
    is          => 'rw',
);

__PACKAGE__->meta->make_immutable;

1;
__END__
