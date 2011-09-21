package Test::MooseX::Types::Locale::Codes::LanguageExtension::Type;


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

use MooseX::Types::Locale::Codes::LanguageExtension qw(
    LanguageExtensionCode
    LanguageExtensionName
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Builder(s)
# ==============================================================================

sub _build_namespace {
    return 'MooseX::Types::Locale::Codes::LanguageExtension';
}

sub _build_default_code_set {
    return 'alpha';
}

sub _build_exported_types {
    return {
        code => { factory => sub { LanguageExtensionCode(shift) },
                  name    => 'LanguageExtensionCode',
                  kind    => 'case sensitive language extension code' },
        name => { factory => sub { LanguageExtensionName(shift) },
                  name    => 'LanguageExtensionName',
                  kind    => 'case sensitive language extension name' },
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
            [ code => [ 'yue',       'yue' ] ],
            [ code => [ 'Yue',       'yue' ] ], # Canonize letter case
            [ code => [ 'xx',        undef ] ],
            [ code => [
                'Yue Chinese',
                'yue'
            ], 'TODO' ],                                # Convert code into name
            [ code => [
                'Yue chinese',
                'yue'
            ], 'TODO' ],                                # Convert code into name
            [ name => [
                'Yue Chinese',
                'Yue Chinese'
            ] ],
            [ name => [
                'Yue chinese',
                'Yue Chinese'
            ] ],                                # Canonize letter case
            [ name => [
                'Kiswahili',
                'Swahili (individual language)'
            ] ],                                # Canonize aliased name
            [ name => [ 'Xxxx Xxxx', undef ] ],
        ],
    };
}

sub _build_dummy_locale_code {
    return {
        adder     => \&Locale::Codes::LangExt::add_langext,
        object    => LanguageExtensionCode,
        type_name => 'LanguageExtensionCode',
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

Test::MooseX::Types::Locale::Codes::LanguageExtension::Type

=cut
