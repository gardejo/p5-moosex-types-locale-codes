package Test::MooseX::Types::Locale::Codes::Script::Type;


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

use MooseX::Types::Locale::Codes::Script qw(
    ScriptCode
    ScriptName
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Builder(s)
# ==============================================================================

sub _build_namespace {
    return 'MooseX::Types::Locale::Codes::Script';
}

sub _build_default_code_set {
    return 'alpha';
}

sub _build_exported_types {
    return {
        code => { factory => sub { ScriptCode(shift) },
                  name    => 'ScriptCode',
                  kind    => 'case sensitive script code' },
        name => { factory => sub { ScriptName(shift) },
                  name    => 'ScriptName',
                  kind    => 'case sensitive script name' },
    };
}

sub _build_aliases_of_code_set {
    return {
        'default' => 'alpha',
        'numeric' => 'num',
        'foobar'  => undef,
    };
}

sub _build_validatees {
    return {
        'alpha' => [
            [ code => [ 'Latn',  'Latn'  ] ],
            [ code => [ 'latn',  'Latn'  ] ],
            [ code => [ 'Xxxx',  undef   ] ],
            [ name => [ 'Latin', 'Latin' ] ],
            [ name => [ 'latin', 'Latin' ] ],
            [ name => [ 'Xxx',   undef   ] ],
        ],
        'numeric' => [
            [ code => [ '160',    '160'    ] ],
            [ code => [ 160,      '160'    ] ],
            [ code => [ '40',     '040'    ] ],
            [ code => [ 40,       '040'    ] ],
            [ code => [ '040',    '040'    ] ],
            [ code => [ 040,      undef    ] ],
            [ code => [ '999',    undef    ] ],
            [ code => [ 999,      undef    ] ],
            [ name => [ 'Arabic', 'Arabic' ] ],
            [ name => [ 'arabic', 'Arabic' ] ],
            [ name => [ 'Xxx',    undef    ] ],
        ],
    };
}

sub _build_dummy_locale_code {
    return {
        adder     => \&Locale::Codes::Script::add_script,
        object    => ScriptCode,
        type_name => 'ScriptCode',
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

Test::MooseX::Types::Locale::Codes::Script::Type

=cut
