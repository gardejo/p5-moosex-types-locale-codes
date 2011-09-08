package MyApp::Locale::Currency;

use namespace::autoclean;

use Moose;

use MooseX::Types::Locale::Codes::Currency qw(
    CurrencyCode
    CurrencyName
);

has 'code' => (
    isa         => CurrencyCode['alpha'],
        # same as : isa => CurrencyCode
    is          => 'rw',
);

has 'name' => (
    isa         => CurrencyName['alpha'],
        # same as : isa => CurrencyName
    is          => 'rw',
);

__PACKAGE__->meta->make_immutable;

1;
__END__
