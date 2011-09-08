package Test::MooseX::Types::Locale::Codes::Constraint;


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

# TODO: Commonalize test cases ( T::M::T::L::C::Language->new->validatees )
has 'initializing_arguments' => (
    traits          => [qw(
        Array
    )],
    isa             => 'ArrayRef[ArrayRef]',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    handles         => {
        count_initializing_arguments => 'count',
        all_initializing_arguments   => 'elements',
    },
    documentation   => 'blah blah blah',
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Test Method(s)
# ==============================================================================

test plan => 'no_plan', constraint => sub {
    my $self = shift;

    my $plan = 0;
    my $target_class = $self->target_class;

    foreach my $initializing_argument ( $self->all_initializing_arguments ) {
        my ($attribute, $from_to) = @$initializing_argument;
        my ($from, $to)           = @$from_to;
        my $locale;

        warning_is
            {
                my $exception = exception {
                    $locale = $target_class->new($attribute => $from);
                };
                if (defined $from && defined $to && $from eq $to) {
                    $self->_passed_in_constraint(
                        $target_class,
                        $locale,
                        $exception,
                        $attribute,
                        $from,
                        $to,
                    );
                    $plan += 3;
                }
                else {
                    $self->_failed_in_constraint(
                        $exception,
                        $attribute,
                        $from,
                    );
                    ++ $plan;
                }
            }
            undef,
            'No warnings for construction about constraint';
        ++ $plan;
    }

    $self->meta->current_method->plan($plan);

    return;
};

# ==============================================================================
# Utility(-ies)
# ==============================================================================

sub _passed_in_constraint {
    my ($self, $target_class, $locale, $exception, $attribute, $from, $to)
        = @_;

    is(
        $exception,
        undef,
        'No exceptions for construction about constraint',
    );

    isa_ok(
        $locale,
        $target_class,
    );

    cmp_ok(
        $locale->$attribute,
        'eq',
        $from,
        sprintf(
            'Attribute %s is %s (passed in constraint)',
            $attribute,
            $to,
        ),
    );

    return;
}

sub _failed_in_constraint {
    my ($self, $exception, $attribute, $from) = @_;

    isnt(
        $exception,
        undef,
        sprintf(
            'Counght exceptions about constraint '
          . '(failed in constraint: %s is not %s)',
            $attribute,
            $from,
        ),
    );

    return;
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

Test::MooseX::Types::Locale::Codes::Constraint

=cut
