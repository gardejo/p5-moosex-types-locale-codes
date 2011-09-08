package MyApp::Locale::LanguageVariation;

use namespace::autoclean;

use Moose;

use MooseX::Types::Locale::Codes::LanguageVariation qw(
    LanguageVariationCode
    LanguageVariationName
);

has 'code' => (
    isa         => LanguageVariationCode['alpha'],
        # same as : isa => LanguageVariationCode
    is          => 'rw',
);

has 'name' => (
    isa         => LanguageVariationName['alpha'],
        # same as : isa => LanguageVariationName
    is          => 'rw',
);

__PACKAGE__->meta->make_immutable;

1;
__END__
