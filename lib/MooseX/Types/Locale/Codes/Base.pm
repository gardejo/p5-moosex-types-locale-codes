package MooseX::Types::Locale::Codes::Base;


# ******************************************************************************
# Dependency(-ies)
# ******************************************************************************

# ==============================================================================
# Pragma(ta)
# ==============================================================================

use 5.008_001;
use strict;
use warnings;

# ==============================================================================
# Namespace Cleaner
# ==============================================================================

use namespace::autoclean;

# ==============================================================================
# General Module(s)
# ==============================================================================

use Devel::PartialDump qw(dump);
use Scalar::Util qw(blessed);


# ******************************************************************************
# Class Variable(s) and Constant(s)
# ******************************************************************************

our $VERSION = '0.00';
our $AUTHORITY = 'cpan:MORIYA';


# ******************************************************************************
# Method(s)
# ******************************************************************************

# ==============================================================================
# Validator(s) : Protected Method(s)
# ==============================================================================

sub validate_code { ## no critic (RequireArgUnpacking)
    my $invocant = shift;

    return $invocant->_validate(
        $invocant->CONVERTER->{code_to_name},
        $invocant->CONVERTER->{name_to_code},
        @_,
    );
}

sub validate_name { ## no critic (RequireArgUnpacking)
    my $invocant = shift;

    return $invocant->_validate(
        $invocant->CONVERTER->{name_to_code},
        $invocant->CONVERTER->{code_to_name},
        @_,
    );
}

# ==============================================================================
# Message Generator(s) : Protected Method(s)
# ==============================================================================

sub message_for_code { ## no critic (RequireArgUnpacking)
    my $invocant = shift;

    return $invocant->_message('code', @_);
}

sub message_for_name { ## no critic (RequireArgUnpacking)
    my $invocant = shift;

    return $invocant->_message('name', @_);
}

# ==============================================================================
# Coercer(s) : Protected Method(s)
# ==============================================================================

sub coerce_code {
    my ($invocant, $code, $code_set) = @_;

    my $canonized_code_set = $invocant->_canonize_code_set($code_set);

    return $invocant->CONVERTER->{code_to_code}->(
        $code, $canonized_code_set, $canonized_code_set
    );
}

sub coerce_name {
    my ($invocant, $name, $code_set) = @_;

    my $canonized_code_set = $invocant->_canonize_code_set($code_set);

    return $invocant->CONVERTER->{code_to_name}->(
        $invocant->CONVERTER->{name_to_code}->($name, $canonized_code_set),
        $canonized_code_set
    );
}

# ==============================================================================
# Utility(-ies) : Protected Method(s)
# ==============================================================================

sub add_option_type_to_map {
    my (undef, @constraints) = @_;

    return
        unless eval { require MooseX::Getopt };

    foreach my $constraint (@constraints) {
        MooseX::Getopt::OptionTypeMap->add_option_type_to_map(
            $constraint => '=s',
        );
    }

    return;
}

# ==============================================================================
# Private Method(s)
# ==============================================================================

sub _validate {
    my ($invocant, $converter, $returner, $original, $code_set) = @_;

    my $canonized_code_set = $invocant->_canonize_code_set($code_set);
    my $converted = $converter->($original, $canonized_code_set);

    return defined $converted
        && $original eq $returner->($converted, $canonized_code_set);
}

sub _message {
    my ($invocant, $kind, $constraint_name, $original, $code_set) = @_;

    my $class = blessed $invocant || $invocant;

    return sprintf(
        'Validation failed for %s failed with value (%s) '
      . 'because specified case sensitive %s %s '
      . 'does not exist in ("%s") code set',
        $class . '::' . $constraint_name,
        dump($original),
        $invocant->LOCALE_TYPE,
        $kind,
        $invocant->_canonize_code_set($code_set),
    );
}

sub _canonize_code_set {
    my ($invocant, $code_set) = @_;

    $code_set = 'default'
        unless defined $code_set;

    return exists $invocant->CANONICAL_CODE_SET_OF->{$code_set}
        ? $invocant->CANONICAL_CODE_SET_OF->{$code_set}
        : $code_set;
}


# ******************************************************************************
# Return True
# ******************************************************************************

1;
__END__


# ******************************************************************************
# Documentation(s)
# ******************************************************************************

=pod

=encoding utf-8

=head1 NAME

MooseX::Types::Locale::Codes::Base - A collection of template methods for MooseX::Types::Locale::Codes (internal use only)

=head1 VERSION

This document describes L<MooseX::Types::Locale::Codes::Base> version C<0.00>.

=head1 SYNOPSIS

    # See MooseX::Types::Locale::Codes::Country for a concrete example
    package MooseX::Types::Locale::Codes::Foobar;

    use parent qw(MooseX::Types::Locale::Codes::Base);

    use constant CANONICAL_CODE_SET_OF => {
        'default' => 'alpha2',
        # ...
    };
    use constant CONVERTER => {
        code_to_code => \&Locale::Codes::Foobar::foobar_code2code,
        code_to_name => \&Locale::Codes::Foobar::code2foobar,
        name_to_code => \&Locale::Codes::Foobar::foobar2code,
    };
    use constant LOCALE_TYPE => 'foobar';

    # ...

=head1 DESCRIPTION

This module packages several template methods for
L<MooseX::Types::Locale::Codes> (B<internal use only>).

=head1 METHODS

The all methods are class methods.

=head2 Validators

=head3 validate_code

    $is_valid = $invocant->validate_code($code, $code_set);

It returns C<true> if the mandatorily supplied C<$code> is in optionally
supplied C<$code_set>, otherwise returns C<false>.
Note that C<$code> is B<case sensitive>.
If C<$code_set> was not supplied, it uses the C<default> code set.

It internally uses L<C<code_to_name()>
|Locale::Codes::API/code2XXX ( CODE [,CODESET] )> and L<C<name_to_code()>
|Locale::Codes::API/XXX2code ( NAME [,CODESET] )> converters which were
provided by C<CONVERTER> constant on each MooseX::Types::Locale::Codes::*
modules for the validation.

It internally converts from aliased C<$code_set> into canonical C<$code_set> by
C<CANONICAL_CODE_SET_OF> constant on each MooseX::Types::Locale::Codes::*
modules.

=head3 validate_name

    $is_valid = $invocant->validate_name($name, $code_set);

It returns C<true> if the mandatorily supplied C<$name> is in optionally
supplied C<$code_set>, otherwise returns C<false>.

Other descriptions are same as L<C<validate_code>|/validate_code>.

=head2 Message Generators

=head3 message_for_code

    $message = $invocant->message_for_code($constraint_name, $code, $code_set);

It returns an error message when a constraint (L<C<validate_code>
|/validate_code>) fails.
C<$constraint_name> and C<$code> are mandatory, and C<$code_set> is optional.
Note that C<$constraint_name> is B<not> a fully qualified type name.
If C<$code_set> was not supplied, it uses the C<default> code set.

It internally uses C<LOCALE_TYPE> constant on each
MooseX::Types::Locale::Codes::* modules for generating a message.

It internally converts from aliased C<$code_set> into canonical C<$code_set> by
C<CANONICAL_CODE_SET_OF> constant on each MooseX::Types::Locale::Codes::*
modules.

=head3 message_for_name

    $message = $invocant->message_for_name($constraint_name, $name, $code_set);

It returns an error message when a constraint (L<C<validate_name>
|/validate_name>) fails.

Other descriptions are same as L<C<message_for_code>|/message_for_code>.

=head2 Coercers

=head3 coerce_code

    $coerced_code = $invocant->coerce_code($original_code, $code_set);

It attempts to return a coerced code of mandatorily supplied C<$original_code>
as optionally supplied C<$code_set> when a constraint (L<C<validate_code>
|/validate_code>) fails, otherwise returns C<undef> when the coercion fails.
If C<$code_set> was not supplied, it uses the C<default> code set.

It internally uses the L<C<code_to_code()>
|Locale::Codes::API/XXX_code2code ( CODE ,CODESET ,CODESET2 )> converter which
was provided by C<CONVERTER> constant on each MooseX::Types::Locale::Codes::*
modules for the coercion.

=head3 coerce_name

    $coerced_name = $invocant->coerce_name($original_name, $code_set);

It attempts to return a coerced code of mandatorily supplied C<$original_name>
as optionally supplied C<$code_set> when a constraint (L<C<validate_name>
|/validate_name>) fails, otherwise returns C<undef> when the coercion fails.
If C<$code_set> was not supplied, it uses the C<default> code set.

It internally uses L<C<name_to_code()>
|Locale::Codes::API/XXX2code ( NAME [,CODESET] )> and L<C<code_to_name()>
|Locale::Codes::API/code2XXX ( CODE [,CODESET] )> converters which were
provided by C<CONVERTER> constant on each MooseX::Types::Locale::Codes::*
modules for the coercion.

=head2 Utility

=head3 add_option_type_to_map

    $invocant->add_option_type_to_map(@constraints);

It attempts to add option type for supplied variadic C<@constraints> to
mappings for L<MooseX::Getopt> when it was installed in your system.
All types are assigned to C<String> (C<"=s">) option types.

=head1 INCOMPATIBILITIES

See L<I<INCOMPATIBILITIES> section of MooseX::Types::Locale::Codes
|MooseX::Types::Locale::Codes/INCOMPATIBILITIES>.

=head1 TO DO

See L<I<TO DO> section of MooseX::Types::Locale::Codes
|MooseX::Types::Locale::Codes/TO DO>.

=head1 BUGS AND LIMITATIONS

See L<I<BUGS AND LIMITATIONS> section of MooseX::Types::Locale::Codes
|MooseX::Types::Locale::Codes/BUGS AND LIMITATIONS>.

=head1 SUPPORT

See L<I<SUPPORT> section of MooseX::Types::Locale::Codes
|MooseX::Types::Locale::Codes/SUPPORT>.

=head1 VERSION CONTROL

See L<I<VERSION CONTROL> section of MooseX::Types::Locale::Codes
|MooseX::Types::Locale::Codes/VERSION CONTROL>.

=head1 AUTHOR

=over 4

=item MORIYA Masaki, alias Gardejo

C<< <moriya at cpan dot org> >>,
L<http://gardejo.org/>

=back

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2009-2011 MORIYA Masaki, alias Gardejo

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
See L<perlgpl> and L<perlartistic>.

The full text of the license can be found in the F<LICENSE> file included with
this distribution.

=cut
