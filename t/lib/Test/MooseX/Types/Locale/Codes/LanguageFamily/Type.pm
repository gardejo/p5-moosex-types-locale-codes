package Test::MooseX::Types::Locale::Codes::LanguageFamily::Type;


# ******************************************************************************
# Dependency(-ies)
# ******************************************************************************

# ==============================================================================
# Test Module(s)
# ==============================================================================

use Test::Able;

# ==============================================================================
# Parent Class(es)
# ==============================================================================

extends qw(
    Test::MooseX::Types::Locale::Codes::Type
);

# ==============================================================================
# Internal Module(s)
# ==============================================================================

use MooseX::Types::Locale::Codes::LanguageFamily qw(
    LanguageFamilyCode
    LanguageFamilyName
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Builder(s)
# ==============================================================================

sub _build_namespace {
    return 'MooseX::Types::Locale::Codes::LanguageFamily';
}

sub _build_default_code_set {
    return 'alpha';
}

sub _build_exported_types {
    return {
        code => { factory => sub { LanguageFamilyCode(shift) },
                  name    => 'LanguageFamilyCode',
                  kind    => 'case sensitive language family code' },
        name => { factory => sub { LanguageFamilyName(shift) },
                  name    => 'LanguageFamilyName',
                  kind    => 'case sensitive language family name' },
    };
}

sub _build_aliases_of_code_set {
    return {
        'default' => 'alpha',
        'foobar'  => undef,
    };
}

sub _build_validatees {
    return {
        'alpha' => [
            [ code => [ 'grk',            'grk' ] ],
            [ code => [ 'GRK',            'grk' ] ], # Canonize letter case
            [ code => [ 'xxxx',           undef ] ],
            [ name => [
                'Greek languages', 'Greek languages'
            ] ],
            [ name => [
                'greek languages', 'Greek languages'
            ] ], # Canonize letter case
            [ name => [ 'Xxxx languages', undef ] ],
        ],
    };
}

sub _build_dummy_locale_code {
    return {
        adder     => \&Locale::Codes::LangFam::add_langfam,
        object    => LanguageFamilyCode,
        type_name => 'LanguageFamilyCode',
        code_set  => 'alpha',
        code      => '!!',
        name      => 'Foobar',
    };
}


# ******************************************************************************
# Compile-Time Process(es)
# ******************************************************************************

__PACKAGE__->meta->make_immutable;


# ******************************************************************************
# Return True
# ******************************************************************************

1;
__END__


# ******************************************************************************
# Documentation
# ******************************************************************************

=pod

=encoding utf-8

=head1 NAME

Test::MooseX::Types::Locale::Codes::LanguageFamily::Type

=cut
