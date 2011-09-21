package Test::MooseX::Types::Locale::Codes::Language::Type;


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

use MooseX::Types::Locale::Codes::Language qw(
    LanguageCode
    LanguageName
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Builder(s)
# ==============================================================================

sub _build_namespace {
    return 'MooseX::Types::Locale::Codes::Language';
}

sub _build_default_code_set {
    return 'alpha2';
}

sub _build_exported_types {
    return {
        code => { factory => sub { LanguageCode(shift) },
                  name    => 'LanguageCode',
                  kind    => 'case sensitive language code' },
        name => { factory => sub { LanguageName(shift) },
                  name    => 'LanguageName',
                  kind    => 'case sensitive language name' },
    };
}

sub _build_aliases_of_code_set {
    return {
        'default'       => 'alpha2',
        'alpha-2'       => 'alpha2',
        'alpha-3'       => 'alpha3',
        'bibliographic' => 'alpha3',
        'terminologic'  => 'term',
        'foobar'        => undef,
    };
}

sub _build_validatees {
    return {
        'alpha-2' => [
            [ code => [ 'en',        'en'      ] ],
            [ code => [ 'EN',        'en'      ] ], # Canonize letter case
            [ code => [ 'xx',        undef     ] ],
            [ code => [ 'English',   'en'      ], 'TODO' ], # Convert code into name
            [ code => [ 'ENGLISH',   'en'      ], 'TODO' ], # Convert code into name
            [ name => [ 'English',   'English' ] ],
            [ name => [ 'ENGLISH',   'English' ] ], # Canonize letter case
            [ name => [ 'Valencian', 'Catalan' ] ], # Canonize aliased name
            [ name => [ 'xx',        undef     ] ],
        ],
        'alpha-3' => [
            [ code => [ 'ger',       'ger'        ] ],
            [ code => [ 'GER',       'ger'        ] ], # Canonize letter case
            [ code => [ 'xxx',       undef        ] ],
            [ code => [ 'German',    'ger'        ], 'TODO' ], # Convert code into name
            [ code => [ 'GERMAN',    'ger'        ], 'TODO' ], # Convert code into name
            [ name => [ 'German',    'German'     ] ],
            [ name => [ 'GERMAN',    'German'     ] ], # Canonize letter case
            [ name => [ 'Low Saxon', 'Low German' ] ], # Canonize aliased name
            [ name => [ 'xxx',       undef        ] ],
        ],
        'terminologic' => [
            [ code => [ 'deu',      'deu'      ] ],
            [ code => [ 'DEU',      'deu'      ] ], # Canonize letter case
            [ code => [ 'xxx',      undef      ] ],
            [ code => [ 'German',   'deu'      ], 'TODO' ], # Convert code into name
            [ code => [ 'GERMAN',   'deu'      ], 'TODO' ], # Convert code into name
            [ name => [ 'German',   'German'   ] ],
            [ name => [ 'GERMAN',   'German'   ] ], # Canonize letter case
            [ name => [ 'Moldovan', 'Romanian' ] ], # Canonize aliased name
            [ name => [ 'xxx',      undef      ] ],
        ],
    };
}

sub _build_dummy_locale_code {
    return {
        adder     => \&Locale::Codes::Language::add_language,
        object    => LanguageCode,
        type_name => 'LanguageCode',
        code_set  => 'alpha2',
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

Test::MooseX::Types::Locale::Codes::Language::Type

=cut
