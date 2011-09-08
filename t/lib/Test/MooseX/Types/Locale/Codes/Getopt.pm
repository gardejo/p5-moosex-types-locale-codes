package Test::MooseX::Types::Locale::Codes::Getopt;


# ******************************************************************************
# Dependency(-ies)
# ******************************************************************************

# ==============================================================================
# Test Module(s)
# ==============================================================================

use Test::Able;
use Test::Fatal;
use Test::More;
use Test::Warn;

# ==============================================================================
# MOP Module(s)
# ==============================================================================

use MooseX::Types::LoadableClass qw(
    LoadableClass
);


# ******************************************************************************
# Attribute(s)
# ******************************************************************************

has 'target_class' => (
    isa             => LoadableClass,
    coerce          => 1,
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    documentation   => 'blah blah blah',
);

has 'initializing_arguments' => (
    traits          => [qw(
        Array
    )],
    isa             => 'ArrayRef[ArrayRef]',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    handles         => {
        all_initializing_arguments   => 'elements',
        count_initializing_arguments => 'count',
    },
    documentation   => 'blah blah blah',
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Test Method(s)
# ==============================================================================

test plan => 'no_plan', getopt => sub {
    my $self = shift;

    $self->meta->current_method->plan(
        4 * $self->count_initializing_arguments
    );

    my $target_class = $self->target_class;

    foreach my $initializing_argument ( $self->all_initializing_arguments ) {
        my ($attribute, $value) = @$initializing_argument;
        my $locale;
        local @ARGV
            = $self->initializing_arguments_to_options($attribute, $value);

        warning_is
            {
                is(
                    exception {
                        $locale = $target_class->new_with_options;
                    },
                    undef,
                    'No exceptions for construction with options',
                );
            }
            undef,
            'No warnings for construction with options';

        isa_ok(
            $locale,
            $target_class,
        );

        cmp_ok(
            $locale->$attribute,
            'eq',
            $value,
            sprintf(
                'Attribute %s is %s with options',
                $attribute,
                $value,
            ),
        );
    }

    return;
};

# ==============================================================================
# Utility(-ies)
# ==============================================================================

sub initializing_arguments_to_options {
    my ($self, $attribute, $value) = @_;

    return (
        '--' . $attribute,
        $value,
    );
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

Test::MooseX::Types::Locale::Codes::Getopt

=cut
