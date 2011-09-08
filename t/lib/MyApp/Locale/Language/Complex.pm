package MyApp::Locale::Language::Complex;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::Language
);

with qw(
    MyApp::Role::Locale::Complexable
);

use Locale::Codes::Language;

has '+code' => (
    lazy_build  => 1,
    trigger     => sub { $_[0]->clear_name },
);

has '+name' => (
    lazy_build  => 1,
    trigger     => sub { $_[0]->clear_code },
);

sub _build_code {
    confess 'Language name was not specified'
        unless $_[0]->has_name;
    return language2code($_[0]->name);
}

sub _build_name {
    confess 'Language code was not specified'
        unless $_[0]->has_code;
    return code2language($_[0]->code);
}

__PACKAGE__->meta->make_immutable;

1;
__END__
