package Test::MooseX::Types::Locale::Codes::Country::Coercion;


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
    return 'MyApp::Locale::Country::Coercible';
}

sub _build_initializing_arguments {
    return [
        [ code => [ 'us',            'us'            ] ],
        [ code => [ 'US',            'us'            ] ],
        [ code => [ 'United States', 'us'            ] ],
        [ code => [ 'United states', 'us'            ] ],
        [ name => [ 'United States', 'United States' ] ],
        [ name => [ 'United states', 'United States' ] ],
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

Test::MooseX::Types::Locale::Codes::Country::Coercion

=cut
