package Test::MooseX::Types::Locale::Codes::Country::Type;


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

use MooseX::Types::Locale::Codes::Country qw(
    CountryCode
    CountryName
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Builder(s)
# ==============================================================================

sub _build_namespace {
    return 'MooseX::Types::Locale::Codes::Country';
}

sub _build_default_code_set {
    return 'alpha2';
}

sub _build_exported_types {
    return {
        code => { factory => sub { CountryCode(shift) },
                  name    => 'CountryCode',
                  kind    => 'case sensitive country code' },
        name => { factory => sub { CountryName(shift) },
                  name    => 'CountryName',
                  kind    => 'case sensitive country name' },
    };
}

sub _build_aliases_of_code_set {
    return {
        'default' => 'alpha2',
        'alpha-2' => 'alpha2',
        'alpha-3' => 'alpha3',
        'numeric' => 'num',
        'fips-10' => 'fips',
        'domain'  => 'dom',
        'foobar'  => undef,
    };
}

sub _build_validatees {
    return {
        'alpha-2' => [
            [ code => [ 'jp',    'jp'    ] ],
            [ code => [ 'JP',    'jp'    ] ],
            [ code => [ 'xx',    undef   ] ],
            [ name => [ 'Japan', 'Japan' ] ],
            [ name => [ 'JAPAN', 'Japan' ] ],
            [ name => [ 'Xxx',   undef   ] ],
        ],
        'alpha-3' => [
            [ code => [ 'deu',     'deu'     ] ],
            [ code => [ 'DEU',     'deu'     ] ],
            [ code => [ 'xxx',     undef     ] ],
            [ name => [ 'Germany', 'Germany' ] ],
            [ name => [ 'GERMANY', 'Germany' ] ],
            [ name => [ 'Xxx',     undef     ] ],
        ],
        'numeric' => [
            [ code => [ '250',    '250'    ] ],
            [ code => [ 250,      '250'    ] ],
            [ code => [ '031',    '031'    ] ],
            [ code => [ 031,      undef    ] ],
            [ code => [ '31',     '031'    ] ],
            [ code => [ 31,       '031'    ] ],
            [ code => [ '999',    undef    ] ],
            [ code => [ 999,      undef    ] ],
            [ name => [ 'France', 'France' ] ],
            [ name => [ 'FRANCE', 'France' ] ],
            [ name => [ 'Xxx',    undef    ] ],
        ],
        'fips-10' => [
            [ code => [ 'JA',    'JA'    ] ],
            [ code => [ 'ja',    'JA'    ] ],
            [ code => [ 'XX',    undef   ] ],
            [ name => [ 'Japan', 'Japan' ] ],
            [ name => [ 'JAPAN', 'Japan' ] ],
            [ name => [ 'Xxx',   undef   ] ],
        ],
        'domain' => [
            [ code => [ 'SE',     'SE'     ] ],
            [ code => [ 'se',     'SE'     ] ],
            [ code => [ 'XX',     undef    ] ],
            [ name => [ 'Sweden', 'Sweden' ] ],
            [ name => [ 'SWEDEN', 'Sweden' ] ],
            [ name => [ 'Xxx',    undef    ] ],
        ],
    };
}

sub _build_dummy_locale_code {
    return {
        adder     => \&Locale::Codes::Country::add_country,
        object    => CountryCode,
        type_name => 'CountryCode',
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

Test::MooseX::Types::Locale::Codes::Country::Type

=cut
