package Test::MooseX::Types::Locale::Codes::Type;


# ******************************************************************************
# Dependency(-ies)
# ******************************************************************************

# ==============================================================================
# Test Module(s)
# ==============================================================================

use Test::Able;
use Test::More;
use Test::Warn;

# ==============================================================================
# General Module(s)
# ==============================================================================

use Devel::PartialDump qw(dump);


# ******************************************************************************
# Attribute(s)
# ******************************************************************************

has 'constraint_type' => (
    isa             => 'ClassName',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    documentation   => 'The base class name of type constraints of Moose',
);

has 'parent_type' => (
    isa             => 'Str',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    documentation   => 'The name of parent type constraint',
);

has 'namespace' => (
    isa             => 'ClassName',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    documentation   => 'The namespace of type constraint',
);

has 'message_template' => (
    isa             => 'Str',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    documentation   => 'The template string for an error message',
);

has 'default_code_set' => (
    isa             => 'Str',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    documentation   => 'The default code set name',
);

has 'exported_types' => (
    traits          => [qw(
        Hash
    )],
    isa             => 'HashRef[HashRef]',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    handles         => {
        all_exported_types    => 'values',
        count_exported_types  => 'count',
        get_exported_type     => 'get',
    },
    documentation   => 'The exported type constraints (Test cases)',
);

has 'aliases_of_code_set' => (
    traits          => [qw(
        Hash
    )],
    isa             => 'HashRef[Maybe[Str]]',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    handles         => {
        count_aliases_of_code_set => 'count',
        pairs_of_alias_to_canon   => 'kv',
    },
    documentation   => 'Aliases of code set (Test cases)',
);

has 'validatees' => (
    traits          => [qw(
        Hash
    )],
    isa             => 'HashRef[ArrayRef]',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    handles         => {
        pairs_of_code_set_to_validatees => 'kv',
    },
    documentation   => 'Pairs of input and expected values for constraints',
);

has 'dummy_locale_code' => (
    isa             => 'HashRef',
    is              => 'ro',
    init_arg        => undef,
    lazy_build      => 1,
    documentation   => 'Dummy (nonexistent) locale code',
);


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Test Method(s)
# ==============================================================================

test plan => 'no_plan', is_a_type => sub {
    my $self = shift;

    $self->meta->current_method->plan( $self->count_exported_types );

    my $constraint_type = $self->constraint_type;

    foreach my $exported_type ( $self->all_exported_types ) {
        isa_ok(
            $exported_type->{factory}->(),
            $constraint_type,
            $exported_type->{name},
        );
    }

    return;
};

test plan => 'no_plan', name => sub {
    my $self = shift;

    $self->meta->current_method->plan( $self->count_exported_types );

    foreach my $exported_type ( $self->all_exported_types ) {
        cmp_ok(
            $exported_type->{factory}->()->name,
            'eq',
            $self->_fully_qualified_class_name( $exported_type->{name} ),
            sprintf(
                'FQCN (fully qualified class name) of %s',
                $exported_type->{name},
            ),
        );
    }

    return;
};

test plan => 'no_plan', parent => sub {
    my $self = shift;

    $self->meta->current_method->plan( $self->count_exported_types * 2 );

    my $parent_type = $self->parent_type;

    foreach my $exported_type ( $self->all_exported_types ) {
        ok(
            $exported_type->{factory}->()->has_parent,
            sprintf(
                '%s has a parent type',
                $exported_type->{name},
            ),
        );

        cmp_ok(
            $exported_type->{factory}->()->parent,
            'eq',
            $parent_type,
            sprintf(
                'Parent type of %s',
                $exported_type->{name},
            ),
        );
    }

    return;
};

test plan => 'no_plan', message => sub {
    my $self = shift;

    $self->meta->current_method->plan( $self->count_exported_types * 2 );

    foreach my $exported_type ( $self->all_exported_types ) {
        ok(
            $exported_type->{factory}->()->has_message,
            sprintf(
                '%s has an error message',
                $exported_type->{name},
            ),
        );

        cmp_ok(
            $exported_type->{factory}->()->message->(),
            'eq',
            $self->_error_message(
                $exported_type->{name},
                undef,
                $exported_type->{kind},
                $self->default_code_set,
            ),
            sprintf(
                'Error message of %s',
                $exported_type->{name},
            ),
        );
    }

    return;
};

test plan => 'no_plan', canonize_code_set => sub {
    my $self = shift;

    $self->meta->current_method->plan( $self->count_aliases_of_code_set * 2 );

    my $canonizer = $self->namespace->CANONICAL_CODE_SET_OF;
    foreach my $pair ( $self->pairs_of_alias_to_canon ) {
        my ($alias, $canon) = @$pair;
        my $canonized;

        warning_is
            { $canonized = $canonizer->{$alias} }
            undef,
            sprintf(
                'No warnings for canonize code set of alias %s to %s',
                dump($alias),
                dump($canon),
            );

        cmp_ok(
            dump($canonized),
            'eq',
            dump($canon),
            sprintf(
                'Canonical code set of alias %s is %s',
                dump($alias),
                dump($canon),
            ),
        );
    }

    return;
};

test plan => 'no_plan', check_and_coerce => sub {
    my $self = shift;

    my $plan = 0;

    foreach my $pair ( $self->pairs_of_code_set_to_validatees ) {
        my ($code_set, $validatees) = @$pair;
        foreach my $validatee (
            @$validatees, $self->_generate_validatees_of_no_coercion
        ) {
            $plan += 4;
            $self->_check_code_or_name($code_set, $validatee);
            $self->_coerce_code_or_name($code_set, $validatee);
        }
    }

    $self->meta->current_method->plan($plan);

    return;
};

test plan => 2, no_caching => sub {
    my $self = shift;

    my $dummy_locale_code = $self->dummy_locale_code;
    my ($adder, $object, $code, $code_set, $type_name, $name)
        = @$dummy_locale_code{qw(adder object code code_set type_name name)};

    ok(
        ! $object->check($code),
        sprintf(
            'Check %s as a code of %s for %s before adding: expect failure',
            $code,
            $code_set,
            $type_name,
        ),
    );

    $adder->($code, $name, $code_set);
    note( sprintf(
        'Added new entry (code is %s, name is %s) to %s code set',
        $code,
        $name,
        $code_set,
    ) );

    ok(
        $object->check($code),
        sprintf(
            'Check %s as a code of %s for %s after adding: expect success',
            $code,
            $code_set,
            $type_name,
        ),
    );

    return;
};

# ==============================================================================
# Utility(-ies)
# ==============================================================================

sub _fully_qualified_class_name {
    my ($self, $suffix) = @_;

    return join '::', $self->namespace, $suffix;
}

sub _error_message {
    my ($self, $suffix, $value, $kind, $code_set) = @_;

    return sprintf(
        $self->message_template,
        $self->_fully_qualified_class_name($suffix),
        dump($value),
        $kind,
        $code_set,
    );
}

sub _check_code_or_name {
    my ($self, $code_set, $validatee) = @_;

    my ($kind, $from_to) = @$validatee;
    my ($from, $to)      = @$from_to;
    my $exported_type    = $self->get_exported_type($kind);
    my $expected_true    = defined $to
                        && $from eq $to;

    my $got_true;
    warning_is
        {
            my $result
                = $exported_type->{factory}->([$code_set])->check($from);
            $got_true = defined $result;
        }
        undef,
        sprintf(
            'No warnings for check %s as a %s of %s for %s',
            dump($from),
            $kind,
            $code_set,
            $exported_type->{name},
        );

    ok(
        ( $expected_true ^ ! $got_true ),
        sprintf(
            'Check %s as a %s of %s for %s: expect %s',
            dump($from),
            $kind,
            $code_set,
            $exported_type->{name},
            ( $expected_true ? 'success' : 'failure' ),
        )
    );

    return;
}

sub _coerce_code_or_name {
    my ($self, $code_set, $validatee) = @_;

    my ($kind, $from_to) = @$validatee;
    my ($from, $to)      = @$from_to;
    my $exported_type    = $self->get_exported_type($kind);
    my $expected_true    = defined $to;

    my $coerced_value;
    warning_is
        { eval {
            $coerced_value
                = $exported_type->{factory}->([$code_set])->coerce($from);
        } }
        undef,
        sprintf(
            'No warnings for coerce from %s to %s as a %s of %s for %s',
            dump($from),
            dump($to),
            $kind,
            $code_set,
            $exported_type->{name},
        );

    my $got_true = defined $to
                && defined $coerced_value
                && $coerced_value eq $to;

    ok(
        ( $expected_true ^ ! $got_true ),
        sprintf(
            'Coerce from %s to %s as a %s of %s for %s: expect %s',
            dump($from),
            dump($to),
            $kind,
            $code_set,
            $exported_type->{name},
            ( $expected_true ? 'coerced' : 'failure' ),
        )
    );

    return;
}

sub _generate_validatees_of_no_coercion {
    my $self = shift;

    return map {
        [ $_ => [ undef, undef ] ], # via Undef
        [ $_ => [ [],    undef ] ], # via ArrayRef
        [ $_ => [ {},    undef ] ], # via HashRef
        [ $_ => [ \'xx', undef ] ], # via ScalarRef
    } qw(code name);
}

# ==============================================================================
# Builder(s)
# ==============================================================================

sub _build_constraint_type {
    return 'Moose::Meta::TypeConstraint';
}

sub _build_parent_type {
    return 'MooseX::Types::Parameterizable::Parameterizable[Str, Maybe[Str]]';
}

sub _build_message_template {
    return 'Validation failed for %s failed with value (%s) '
         . 'because specified %s does not exist in ("%s") code set';
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

Test::MooseX::Types::Locale::Codes::Type

=cut
