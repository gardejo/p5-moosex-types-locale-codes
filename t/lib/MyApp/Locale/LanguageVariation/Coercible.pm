package MyApp::Locale::LanguageVariation::Coercible;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::LanguageVariation
);

has '+code' => (
    coerce      => 1,
);

has '+name' => (
    coerce      => 1,
);

__PACKAGE__->meta->make_immutable;

1;
__END__
