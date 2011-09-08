package MyApp::Locale::Currency::Complex;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::Currency
);

with qw(
    MyApp::Role::Locale::Complexable
);

use Locale::Codes::Currency;

has '+code' => (
    lazy_build  => 1,
    trigger     => sub { $_[0]->clear_name },
);

has '+name' => (
    lazy_build  => 1,
    trigger     => sub { $_[0]->clear_code },
);

sub _build_code {
    confess 'Currency name was not specified'
        unless $_[0]->has_name;
    return currency2code($_[0]->name);
}

sub _build_name {
    confess 'Currency code was not specified'
        unless $_[0]->has_code;
    return code2currency($_[0]->code);
}

__PACKAGE__->meta->make_immutable;

1;
__END__
