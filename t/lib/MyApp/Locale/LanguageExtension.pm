package MyApp::Locale::LanguageExtension;

use namespace::autoclean;

use Moose;

use MooseX::Types::Locale::Codes::LanguageExtension qw(
    LanguageExtensionCode
    LanguageExtensionName
);

has 'code' => (
    isa         => LanguageExtensionCode['alpha'],
        # same as : isa => LanguageExtensionCode
    is          => 'rw',
);

has 'name' => (
    isa         => LanguageExtensionName['alpha'],
        # same as : isa => LanguageExtensionName
    is          => 'rw',
);

__PACKAGE__->meta->make_immutable;

1;
__END__
