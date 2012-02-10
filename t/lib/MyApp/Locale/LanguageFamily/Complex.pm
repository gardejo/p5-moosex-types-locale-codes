package MyApp::Locale::LanguageFamily::Complex;

use namespace::autoclean;

use Moose;

extends qw(
    MyApp::Locale::LanguageFamily
);

with qw(
    MyApp::Role::Locale::Complexable
);

use Locale::Codes::LangFam;

has '+code' => (
    lazy_build  => 1,
    trigger     => sub { $_[0]->clear_name },
);

has '+name' => (
    lazy_build  => 1,
    trigger     => sub { $_[0]->clear_code },
);

sub _build_code {
    confess 'Language family name was not specified'
        unless $_[0]->has_name;
    return langfam2code($_[0]->name);
}

sub _build_name {
    confess 'Language family code was not specified'
        unless $_[0]->has_code;
    return code2langfam($_[0]->code);
}

__PACKAGE__->meta->make_immutable;

1;
__END__
