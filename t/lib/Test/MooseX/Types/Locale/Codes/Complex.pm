package Test::MooseX::Types::Locale::Codes::Complex;


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

has 'alignments' => (
    traits          => [qw(
        Array
    )],
    isa             => 'ArrayRef[ArrayRef]',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    handles         => {
        all_alignments => 'elements',
    },
    documentation   => 'blah blah blah',
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Test Method(s)
# ==============================================================================

test plan => 'no_plan', complex => sub {
    my $self = shift;

    my $plan = 0;
    my $target_class = $self->target_class;

    foreach my $alignment ( $self->all_alignments ) {
        my ($from, $to) = @$alignment;
        if (defined $to) {
            $self->_normally_construct($target_class, $from, $to);
            $plan += 7;
        }
        else {
            $self->_abnormally_construct($target_class, $from);
            ++ $plan;
        }
    }

    $self->meta->current_method->plan($plan);

    return;
};

# ==============================================================================
# Utility(-ies)
# ==============================================================================

sub _normally_construct {
    my ($self, $target_class, $from, $to) = @_;

    my ($from_attribute, $from_value) = @$from;
    my ($to_attribute,   $to_value  ) = @$to;
    my $locale;

    warning_is
        {
            is(
                exception {
                    $locale = $target_class->new(
                        $from_attribute => $from_value
                    );
                },
                undef,
                'No exceptions for construction',
            );
        }
        undef,
        'No warnings for construction about constraint';

    isa_ok(
        $locale,
        $target_class,
    );

    cmp_ok(
        $locale->$from_attribute,
        'eq',
        $from_value,
        sprintf(
            'Attribute %s is %s (passed in constraint)',
            $from_attribute,
            $from_value,
        ),
    );

    my $result;
    warning_is
        {
            is(
                exception {
                    $result = $locale->$to_attribute;
                },
                undef,
                'No exceptions for accessor',
            );
        }
        undef,
        'No warnings for construction about building';

    cmp_ok(
        $result,
        'eq',
        $to_value,
        sprintf(
            'Attribute %s is %s (passed in building)',
            $to_attribute,
            $to_value,
        ),
    );

    return;
}

sub _abnormally_construct {
    my ($self, $target_class, $from) = @_;

    isnt(
        exception {
            $target_class->new($from);
        },
        undef,
        'Construtor throws an exception by mutually exclusive attributes',
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

Test::MooseX::Types::Locale::Codes::Coercion

=cut
