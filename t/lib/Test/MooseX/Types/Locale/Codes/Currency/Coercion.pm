package Test::MooseX::Types::Locale::Codes::Currency::Coercion;


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
    Test::MooseX::Types::Locale::Codes::Coercion
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Builder(s)
# ==============================================================================

sub _build_target_class {
    return 'MyApp::Locale::Currency::Coercible';
}

sub _build_initializing_arguments {
    return [
        [ code => [ 'USD',       'USD'       ] ],
        [ code => [ 'usd',       'USD'       ] ],
        [ name => [ 'US Dollar', 'US Dollar' ] ],
        [ name => [ 'US dollar', 'US Dollar' ] ],
    ];
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

Test::MooseX::Types::Locale::Codes::Currency::Coercion

=cut
