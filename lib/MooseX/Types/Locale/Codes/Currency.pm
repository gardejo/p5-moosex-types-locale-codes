package MooseX::Types::Locale::Codes::Currency;


# ******************************************************************************
# Dependency(-ies)
# ******************************************************************************

# ==============================================================================
# Pragma(ta)
# ==============================================================================

use 5.008_001;
# MooseX::Types turns strict/warnings pragmas on,
# however, kwalitee scorer can not detect such mechanism.
# (Perl::Critic can it, with equivalent_modules parameter)
use strict;
use warnings;

# ==============================================================================
# Namespace Cleaner
# ==============================================================================

use namespace::autoclean;

# ==============================================================================
# MOP Module(s)
# ==============================================================================

use MooseX::Types -declare => [qw(CurrencyCode CurrencyName)];
use MooseX::Types::Moose qw(Maybe Str);
use MooseX::Types::Parameterizable 0.07 qw(Parameterizable); ### TODO: 0.08

# ==============================================================================
# General Module(s)
# ==============================================================================

use Locale::Codes::Currency 3.17 qw();

# ==============================================================================
# Internal Module(s)
# ==============================================================================

use parent qw(MooseX::Types::Locale::Codes::Base);


# ******************************************************************************
# Class Variable(s) and Constant(s)
# ******************************************************************************

our $VERSION = '0.00';
our $AUTHORITY = 'cpan:MORIYA';

use constant CANONICAL_CODE_SET_OF => {
    'default' => 'alpha',
    'numeric' => 'num',
};

use constant CONVERTER => {
    code_to_code => \&Locale::Codes::Currency::currency_code2code,
    code_to_name => \&Locale::Codes::Currency::code2currency,
    name_to_code => \&Locale::Codes::Currency::currency2code,
};

use constant LOCALE_TYPE => 'currency';


# ******************************************************************************
# Type Constraint(s) and Coercion(s)
# ******************************************************************************

# ==============================================================================
# Currency Code
# ==============================================================================

subtype CurrencyCode,
    as Parameterizable[Str, Maybe[Str]],
        where {
            return __PACKAGE__->validate_code(@_);
        },
        message {
            return __PACKAGE__->message_for_code('CurrencyCode', @_);
        };

coerce CurrencyCode,
    from Str,
        via {
            return __PACKAGE__->coerce_code(@_);
        };

# ==============================================================================
# Currency Name
# ==============================================================================

subtype CurrencyName,
    as Parameterizable[Str, Maybe[Str]],
        where {
            return __PACKAGE__->validate_name(@_);
        },
        message {
            return __PACKAGE__->message_for_name('CurrencyName', @_);
        };

coerce CurrencyName,
    from Str,
        via {
            return __PACKAGE__->coerce_name(@_);
        };


# ******************************************************************************
# Optionally Add Getopt Option Type
# ******************************************************************************

if ( eval { require MooseX::Getopt } ) {
    foreach my $constraint (CurrencyCode, CurrencyName) {
        MooseX::Getopt::OptionTypeMap->add_option_type_to_map(
            $constraint => '=s',
        );
    }
}


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

MooseX::Types::Locale::Codes::Currency - Locale::Codes::Currency related type constraints and coercions for Moose

=head1 VERSION

This document describes L<MooseX::Types::Locale::Codes::Currency> version
C<0.00>.

=head1 SYNOPSIS

    {
        package MyApp::Locale::Currency;

        use Moose;
        use MooseX::Types::Locale::Codes::Currency qw(
            CurrencyCode
            CurrencyName
        );

        has 'code' => (isa => CurrencyCode, coerce => 1, is => 'rw');
        has 'name' => (isa => CurrencyName, coerce => 1, is => 'rw');

        __PACKAGE__->meta->make_immutable;
    }

    my $currency = MyApp::Locale::Currency->new(
        code => 'usd',
        name => 'us dollar',
    );
    print $currency->code; # 'USD'       (letter case was canonized)
    print $currency->name; # 'US Dollar' (letter case was canonized)

=head1 DESCRIPTION

This module packages several L<parameterizable|MooseX::Types::Parameterizable>
L<type constraints|Moose::Meta::TypeConstraint> and L<coercions
|Moose::Meta::TypeCoercion> for L<Moose>.
They were designed to work with the suite of codes and names from
L<Locale::Codes::Currency>.
The parameters correspond to L<code sets of currencies
|Locale::Codes::Currency/SUPPORTED CODE SETS>.

It is a part of L<MooseX::Types::Locale::Codes>.

=head1 TYPE CONSTRAINTS AND COERCIONS

=head2 CurrencyCode[`a]

=head3 C<CurrencyCode>

An alias of L<C<CurrencyCode['alpha']>|/CurrencyCode['alpha']>.

=head3 C<CurrencyCode['alpha']>

A subtype of C<Str>, which should be defined in B<case sensitive> currency code
of ISO 4217.
For example, it allows not C<'usd'> but C<'USD'> as C<'US Dollar'>.

If you turned C<coerce> option on, C<Str> will be upper-case.
For example, C<'usd'> will convert to C<'USD'>.

The parameter corresponds to L<C<alpha> currency code set
|Locale::Codes::Currency/alpha> identified with the symbol
C<LOCALE_CURR_ALPHA>.

=head3 C<CurrencyCode['numeric']>

A subtype of C<Str>, which should be defined in numeric currency code of ISO
4217.
For example, it allows not C<'36'> but C<'036'> as C<'Australian Dollar'>.

If you turned C<coerce> option on, C<Str> will be canonical number.
For example, C<36> and C<'36'> will convert to C<'036'>.

The parameter corresponds to L<C<num> currency code set
|Locale::Codes::Currency/num> identified with the symbol
C<LOCALE_CURR_NUMERIC>.

=head3 C<CurrencyCode['num']>

An alias of L<C<CurrencyCode['numeric']>|/CurrencyCode['numeric']>.

=head2 CurrencyName[`a]

=head3 C<CurrencyName>

An alias of L<C<CurrencyName['alpha']>|/CurrencyName['alpha']>.

=head3 C<CurrencyName['alpha']>

A subtype of C<Str>, which should be defined in B<case sensitive> currency name
of ISO 4217.
For example, it allows not C<'YEN'> but C<'Yen'> as C<'JPY'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'YEN'> will convert to C<'Yen'>
(Note that L<Locale::Codes::Currency> has no aliased name of currency in
C<'alpha'> currency code set yet).

The parameter corresponds to L<C<alpha> currency code set
|Locale::Codes::Currency/alpha> identified with the symbol
C<LOCALE_CURR_ALPHA>.

=head3 C<CurrencyName['numeric']>

A subtype of C<Str>, which should be defined in B<case sensitive> currency name
of ISO 4217.
For example, it allows not C<'EURO'> but C<'Euro'> as C<'978'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'EURO'> will convert to C<'Euro'>
(Note that L<Locale::Codes::Currency> has no aliased name of currency in
C<'num'> currency code set yet).

The parameter corresponds to L<C<num> currency code set
|Locale::Codes::Currency/num> identified with the symbol
C<LOCALE_CURR_NUMERIC>.

=head3 C<CurrencyName['num']>

An alias of L<C<CurrencyName['numeric']>|/CurrencyName['numeric']>.

=head1 CLASS CONSTANTS

These class L<constant>s are for B<internal use only>.

=over 4

=item C<CANONICAL_CODE_SET_OF>

It is a hash reference which contains pairs of alias to canonical name of
L<code sets of currencies|Locale::Codes::Currency/SUPPORTED CODE SETS>.

=item C<CONVERTER>

It is a hash reference which contains pairs of alias to subroutine references
of L<converters of currencies|Locale::Codes::Currency/ROUTINES>.

=item C<LOCALE_TYPE>

It is a string which was used by error messages.

=back

=head1 EXPORTS

These type constraints are not exported by default but you can request them in
an import list like this:

    use MooseX::Types::Locale::Codes::Currency qw(
        CurrencyCode
        CurrencyName
    );

=head1 NOTES

=head2 Aliases of Currency will be Canonized

See L<I<Aliases of Locale will be Canonized> section of
MooseX::Types::Locale::Codes
|MooseX::Types::Locale::Codes/Aliases of Locale will be Canonized>.

=head2 Behaviors of Coercions are Only Canonization

See L<I<Behaviors of Coercions are Only Canonization> section of
MooseX::Types::Locale::Codes
|MooseX::Types::Locale::Codes/Behaviors of Coercions are Only Canonization>.

=head2 Option Types for L<MooseX::Getopt>

See L<I<Option Types for MooseX::Getopt> section of
MooseX::Types::Locale::Codes
|MooseX::Types::Locale::Codes/Option Types for MooseX::Getopt>.

=head2 History

This module was B<NOT> previously known as L<MooseX::Types::Locale::Currency>
which was made by Caleb Cushing.
Please pay careful attention to the difference between the two modules.

=head1 SEE ALSO

=head2 L<Moose> Related Documents

=over 4

=item *

L<Moose::Manual::Types>

=item *

L<MooseX::Types>

=item *

L<MooseX::Types::Parameterizable>

=back

=head2 L<Locale::Codes> Related Documents

=over 4

=item *

L<Locale::Codes::Currency>

=back

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
