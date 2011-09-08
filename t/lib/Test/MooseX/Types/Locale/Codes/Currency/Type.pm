package Test::MooseX::Types::Locale::Codes::Currency::Type;


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

use MooseX::Types::Locale::Codes::Currency qw(
    CurrencyCode
    CurrencyName
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Builder(s)
# ==============================================================================

sub _build_namespace {
    return 'MooseX::Types::Locale::Codes::Currency';
}

sub _build_default_code_set {
    return 'alpha';
}

sub _build_exported_types {
    return {
        code => { factory => sub { CurrencyCode(shift) },
                  name    => 'CurrencyCode',
                  kind    => 'case sensitive currency code' },
        name => { factory => sub { CurrencyName(shift) },
                  name    => 'CurrencyName',
                  kind    => 'case sensitive currency name' },
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
            [ code => [ 'USD',       'USD'       ] ],
            [ code => [ 'usd',       'USD'       ] ],
            [ code => [ 'XXX',       undef       ] ],
            [ name => [ 'US Dollar', 'US Dollar' ] ],
            [ name => [ 'US dollar', 'US Dollar' ] ],
            [ name => [ 'xxx',       undef       ] ],
        ],
        'numeric' => [
            [ code => [ '392', '392'  ] ],
            [ code => [ 392,   '392'  ] ],
            [ code => [ '012', '012'  ] ],
            [ code => [ 012,   undef  ] ],
            [ code => [ '12',  '012'  ] ],
            [ code => [ 12,    '012'  ] ],
            [ code => [ '999', undef  ] ],
            [ code => [ 999,   undef  ] ],
            [ name => [ 'Yen', 'Yen'  ] ],
            [ name => [ 'yen', 'Yen'  ] ],
            [ name => [ 'Xxx', undef  ] ],
        ],
    };
}

sub _build_dummy_locale_code {
    return {
        adder     => \&Locale::Codes::Currency::add_currency,
        object    => CurrencyCode,
        type_name => 'CurrencyCode',
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

Test::MooseX::Types::Locale::Codes::Currency::Type

=cut
