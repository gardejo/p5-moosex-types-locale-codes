package MyApp::Locale::Country::Complex;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::Country
);

with qw(
    MyApp::Role::Locale::Complexable
);

use Locale::Codes::Country;

has '+code' => (
    lazy_build  => 1,
    trigger     => sub { $_[0]->clear_name },
);

has '+name' => (
    lazy_build  => 1,
    trigger     => sub { $_[0]->clear_code },
);

sub _build_code {
    confess 'Country name was not specified'
        unless $_[0]->has_name;
    return country2code($_[0]->name);
}

sub _build_name {
    confess 'Country code was not specified'
        unless $_[0]->has_code;
    return code2country($_[0]->code);
}

__PACKAGE__->meta->make_immutable;

1;
__END__
