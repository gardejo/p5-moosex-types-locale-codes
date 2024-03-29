package Test::MooseX::Types::Locale::Codes::Script::Constraint;


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
    Test::MooseX::Types::Locale::Codes::Constraint
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Builder(s)
# ==============================================================================

sub _build_target_class {
    return 'MyApp::Locale::Script';
}

sub _build_initializing_arguments {
    return [
        [ code => [ 'Latn',  'Latn'  ] ],
        [ code => [ 'latn',  'Latn'  ] ],
        [ name => [ 'Latin', 'Latin' ] ],
        [ name => [ 'latin', 'Latin' ] ],
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

Test::MooseX::Types::Locale::Codes::Script::Constraint

=cut
