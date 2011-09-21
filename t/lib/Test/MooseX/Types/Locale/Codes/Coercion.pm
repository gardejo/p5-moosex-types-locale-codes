package Test::MooseX::Types::Locale::Codes::Coercion;


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

test plan => 'no_plan', coercion => sub {
    my $self = shift;

    $self->meta->current_method->plan(
        4 * $self->count_initializing_arguments
    );

    my $target_class = $self->target_class;

    foreach my $initializing_argument ( $self->all_initializing_arguments ) {
        my ($attribute, $from_to) = @$initializing_argument;
        my ($from, $to)           = @$from_to;
        my $locale;

        my $exception;
        warning_is
            {
                TODO: {
                    local $TODO = 'Because a constraint which made by '
                                . 'MooseX::Types::Parameterizable does not '
                                . 'work with recent Moose, or, '
                                . 'a constraint does not support additional '
                                . 'coercion, which converts name to code yet.';

                    is(
                        $exception = exception {
                            $locale = $target_class->new($attribute => $from);
                        },
                        undef,
                        'No exceptions for construction about coercion',
                    );
                };
            }
            undef,
            'No warnings for construction about coercion';

        SKIP: {
            skip(
                'Coercion failed',
                2,
            )
                if defined $exception;

            isa_ok(
                $locale,
                $target_class,
            );

            cmp_ok(
                $locale->$attribute,
                'eq',
                $to,
                sprintf(
                    'Attribute %s is %s from %s (passed in coercion)',
                    $attribute,
                    $to,
                    $from,
                ),
            );
        };
    }

    return;
};


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

Test::MooseX::Types::Locale::Codes::Coercion

=cut
