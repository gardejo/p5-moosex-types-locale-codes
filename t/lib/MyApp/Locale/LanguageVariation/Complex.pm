package MyApp::Locale::LanguageVariation::Complex;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::LanguageVariation
);

with qw(
    MyApp::Role::Locale::Complexable
);

use Locale::Codes::LangVar;

has '+code' => (
    lazy_build  => 1,
    trigger     => sub { $_[0]->clear_name },
);

has '+name' => (
    lazy_build  => 1,
    trigger     => sub { $_[0]->clear_code },
);

sub _build_code {
    confess 'Language variation name was not specified'
        unless $_[0]->has_name;
    return langvar2code($_[0]->name);
}

sub _build_name {
    confess 'Language variation code was not specified'
        unless $_[0]->has_code;
    return code2langvar($_[0]->code);
}

__PACKAGE__->meta->make_immutable;

1;
__END__
