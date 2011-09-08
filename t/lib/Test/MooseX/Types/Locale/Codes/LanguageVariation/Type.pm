package Test::MooseX::Types::Locale::Codes::LanguageVariation::Type;


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

use MooseX::Types::Locale::Codes::LanguageVariation qw(
    LanguageVariationCode
    LanguageVariationName
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Builder(s)
# ==============================================================================

sub _build_namespace {
    return 'MooseX::Types::Locale::Codes::LanguageVariation';
}

sub _build_default_code_set {
    return 'alpha';
}

sub _build_exported_types {
    return {
        code => { factory => sub { LanguageVariationCode(shift) },
                  name    => 'LanguageVariationCode',
                  kind    => 'case sensitive language variation code' },
        name => { factory => sub { LanguageVariationName(shift) },
                  name    => 'LanguageVariationName',
                  kind    => 'case sensitive language variation name' },
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
            [ code => [ 'rozaj',  'rozaj'  ] ],
            [ code => [ 'Rozaj',  'rozaj'  ] ],
            [ code => [ 'xxxx',   undef    ] ],
            [ name => [ 'Resian', 'Resian' ] ],
            [ name => [ 'resian', 'Resian' ] ],
            [ name => [ 'Xxxx',   undef    ] ],
        ],
    };
}

sub _build_dummy_locale_code {
    return {
        adder     => \&Locale::Codes::LangVar::add_langvar,
        object    => LanguageVariationCode,
        type_name => 'LanguageVariationCode',
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

Test::MooseX::Types::Locale::Codes::LanguageVariation::Type

=cut
