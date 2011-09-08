package MyApp::Locale::Country;

use namespace::autoclean;

use Moose;

use MooseX::Types::Locale::Codes::Country qw(
    CountryCode
    CountryName
);

has 'code' => (
    isa         => CountryCode['alpha2'],
        # same as : isa => CountryCode
    is          => 'rw',
);

has 'name' => (
    isa         => CountryName['alpha2'],
        # same as : isa => CountryName
    is          => 'rw',
);

__PACKAGE__->meta->make_immutable;

1;
__END__
