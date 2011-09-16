package MooseX::Types::Locale::Codes::Country;


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

use MooseX::Types -declare => [qw(CountryCode CountryName)];
use MooseX::Types::Moose qw(Maybe Str);
use MooseX::Types::Parameterizable 0.07 qw(Parameterizable); ### TODO: 0.08

# ==============================================================================
# General Module(s)
# ==============================================================================

use Locale::Codes::Country 3.17 qw();

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
    'alpha-2' => 'alpha2',
    'alpha-3' => 'alpha3',
    'default' => 'alpha2',
    'domain'  => 'dom',
    'fips-10' => 'fips',
    'fips10'  => 'fips',
    'numeric' => 'num',
};

use constant CONVERTER => {
    code_to_code => \&Locale::Codes::Country::country_code2code,
    code_to_name => \&Locale::Codes::Country::code2country,
    name_to_code => \&Locale::Codes::Country::country2code,
};

use constant LOCALE_TYPE => 'country';


# ******************************************************************************
# Type Constraint(s) and Coercion(s)
# ******************************************************************************

# ==============================================================================
# Country Code
# ==============================================================================

subtype CountryCode,
    as Parameterizable[Str, Maybe[Str]],
        where {
            return __PACKAGE__->validate_code(@_);
        },
        message {
            return __PACKAGE__->message_for_code('CountryCode', @_);
        };

coerce CountryCode,
    from Str,
        via {
            return __PACKAGE__->coerce_code(@_);
        };

# ==============================================================================
# Country Name
# ==============================================================================

subtype CountryName,
    as Parameterizable[Str, Maybe[Str]],
        where {
            return __PACKAGE__->validate_name(@_);
        },
        message {
            return __PACKAGE__->message_for_name('CountryName', @_);
        };

coerce CountryName,
    from Str,
        via {
            return __PACKAGE__->coerce_name(@_);
        };


# ******************************************************************************
# Optionally Add Getopt Option Type
# ******************************************************************************

if ( eval { require MooseX::Getopt } ) {
    foreach my $constraint (CountryCode, CountryName) {
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

MooseX::Types::Locale::Codes::Country - Locale::Codes::Country related type constraints and coercions for Moose

=head1 VERSION

This document describes L<MooseX::Types::Locale::Codes::Country> version
C<0.00>.

=head1 SYNOPSIS

    {
        package MyApp::Locale::Country;

        use Moose;
        use MooseX::Types::Locale::Codes::Country qw(
            CountryCode
            CountryName
        );

        has 'code' => (isa => CountryCode, coerce => 1, is => 'rw');
        has 'name' => (isa => CountryName, coerce => 1, is => 'rw');

        __PACKAGE__->meta->make_immutable;
    }

    my $country = MyApp::Locale::Country->new(
        code => 'us',
        name => 'UNITED STATES',
    );
    print $country->code; # 'US'            (letter case was canonized)
    print $country->name; # 'United States' (letter case was canonized)

=head1 DESCRIPTION

This module packages several L<parameterizable|MooseX::Types::Parameterizable>
L<type constraints|Moose::Meta::TypeConstraint> and L<coercions
|Moose::Meta::TypeCoercion> for L<Moose>.
They were designed to work with the suite of codes and names from
L<Locale::Codes::Country>.
The parameters correspond to L<code sets of countries
|Locale::Codes::Country/SUPPORTED CODE SETS>.

It is a part of L<MooseX::Types::Locale::Codes>.

=head1 TYPE CONSTRAINTS AND COERCIONS

=head2 CountryCode[`a]

=head3 C<CountryCode>

An alias of L<C<CountryCode['alpha-2']>|/CountryCode['alpha-2']>.

=head3 C<CountryCode['alpha-2']>

A subtype of C<Str>, which should be defined in B<case sensitive> country code
of ISO 3166-1 alpha-2.
For example, it allows not C<'JP'> but C<'jp'> as C<'Japan'>.

If you turned C<coerce> option on, C<Str> will be lower-case.
For example, C<'JP'> will convert to C<'jp'>.

The parameter corresponds to L<C<alpha-2> country code set
|Locale::Codes::Country/alpha-2> identified with the symbol
C<LOCALE_CODE_ALPHA_2>.

=head3 C<CountryCode['alpha2']>

An alias of L<C<CountryCode['alpha-2']>|/CountryCode['alpha-2']>.

=head3 C<CountryCode['alpha-3']>

A subtype of C<Str>, which should be defined in B<case sensitive> country code
of ISO 3166-1 alpha-3.
For example, it allows not C<'DEU'> but C<'deu'> as C<'Germany'>.

If you turned C<coerce> option on, C<Str> will be lower-case.
For example, C<'DEU'> will convert to C<'deu'>.

The parameter corresponds to L<C<alpha-3> country code set
|Locale::Codes::Country/alpha-3> identified with the symbol
C<LOCALE_CODE_ALPHA_3>.

=head3 C<CountryCode['alpha3']>

An alias of L<C<CountryCode['alpha-3']>|/CountryCode['alpha-3']>.

=head3 C<CountryCode['numeric']>

A subtype of C<Str>, which should be defined in numeric country code of ISO
3166-1.
For example, it allows not C<'12'> but C<'012'> as C<'Algeria'>.

If you turned C<coerce> option on, C<Str> will be canonical number.
For example, C<12> and C<'12'> will convert to C<'012'>.

The parameter corresponds to L<C<numeric> country code set
|Locale::Codes::Country/numeric> identified with the symbol
C<LOCALE_CODE_NUMERIC>.

Note that it is not a subtype of C<Int>.

=head3 C<CountryCode['num']>

An alias of L<C<CountryCode['numeric']>|/CountryCode['numeric']>.

=head3 C<CountryCode['fips-10']>

A subtype of C<Str>, which should be defined in B<case sensitive> country code
of FIPS 10.
For example, it allows not C<'ja'> but C<'JA'> as C<'Japan'>.

If you turned C<coerce> option on, C<Str> will be upper-case.
For example, C<'ja'> will convert to C<'JA'>.

The parameter corresponds to L<C<fips-10> country code set
|Locale::Codes::Country/fips-10> identified with the symbol
C<LOCALE_CODE_FIPS>.

=head3 C<CountryCode['fips10']>

An alias of L<C<CountryCode['fips-10']>|/CountryCode['fips-10']>.

=head3 C<CountryCode['fips']>

An alias of L<C<CountryCode['fips-10']>|/CountryCode['fips-10']>.

=head3 C<CountryCode['domain']>

A subtype of C<Str>, which should be defined in B<case sensitive> country code
of IANA domain name registry.
For example, it allows not C<'eu'> but C<'EU'> as C<'European Union'>.

If you turned C<coerce> option on, C<Str> will be upper-case.
For example, C<'eu'> will convert to C<'EU'>.

The parameter corresponds to L<C<dom> country code set
|Locale::Codes::Country/dom> identified with the symbol C<LOCALE_CODE_DOM>.

=head3 C<CountryCode['dom']>

An alias of L<C<CountryCode['domain']>|/CountryCode['domain']>.

=head2 CountryName[`a]

=head3 C<CountryName>

An alias of L<C<CountryName['alpha-2']>|/CountryName['alpha-2']>.

=head3 C<CountryName['alpha-2']>

A subtype of C<Str>, which should be defined in B<case sensitive> country name
of ISO 3166-1 alpha-2.
For example, it allows not C<'Heard Island And Mcdonald Islands'> but
C<'Heard Island and McDonald Islands'> as C<'hm'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'Heard Island And Mcdonald Islands'> will convert to
C<'Heard Island and McDonald Islands'> and C<'Vatican City'> will convert to
C<'Holy See (Vatican City State)'>.

The parameter corresponds to L<C<alpha-2> country code set
|Locale::Codes::Country/alpha-2> identified with the symbol
C<LOCALE_CODE_ALPHA_2>.

=head3 C<CountryName['alpha2']>

An alias of L<C<CountryName['alpha-2']>|/CountryName['alpha-2']>.

=head3 C<CountryName['alpha-3']>

A subtype of C<Str>, which should be defined in B<case sensitive> country name
of ISO 3166-1 alpha-3.
For example, it allows not C<'france'> but C<'France'> as C<'fra'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'france'> will convert to C<'France'> and C<'United States'>
will convert to C<'United States of America'>.

The parameter corresponds to L<C<alpha-3> country code set
|Locale::Codes::Country/alpha-3> identified with the symbol
C<LOCALE_CODE_ALPHA_3>.

=head3 C<CountryName['alpha3']>

An alias of L<C<CountryName['alpha-3']>|/CountryName['alpha-3']>.

=head3 C<CountryName['numeric']>

A subtype of C<Str>, which should be defined in B<case sensitive> country name
of ISO 3166-1.
For example, it allows not C<'ALGERIA'> but C<'Algeria'> as C<'012'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'ALGERIA'> will convert to C<'Algeria'> and C<'Great Britain'>
will convert to C<'United Kingdom of Great Britain and Northern Ireland'>.

The parameter corresponds to L<C<numeric> country code set
|Locale::Codes::Country/numeric> identified with the symbol
C<LOCALE_CODE_NUMERIC>.

=head3 C<CountryName['num']>

An alias of L<C<CountryName['numeric']>|/CountryName['numeric']>.

=head3 C<CountryName['fips-10']>

A subtype of C<Str>, which should be defined in B<case sensitive> country name
of FIPS 10.
For example, it allows not C<'JAPAN'> but C<'Japan'> as C<'JA'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'japan'> will convert to C<'Japan'> and C<'Great Britain'> will
convert to C<'United Kingdom'>.

The parameter corresponds to L<C<fips-10> country code set
|Locale::Codes::Country/fips-10> identified with the symbol
C<LOCALE_CODE_FIPS>.

=head3 C<CountryName['fips10']>

An alias of L<C<CountryName['fips-10']>|/CountryName['fips-10']>.

=head3 C<CountryName['fips']>

An alias of L<C<CountryName['fips-10']>|/CountryName['fips-10']>.

=head3 C<CountryName['domain']>

A subtype of C<Str>, which should be defined in B<case sensitive> country name
of IANA domain name registry (ccTLD).
For example, it allows not C<'united kingdom'> but C<'United Kingdom'> as
C<'UK'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'united kingdom'> will convert to C<'United Kingdom'> and
C<'Republic of Turkey'> will convert to C<'Turkey'>.

The parameter corresponds to L<C<dom> country code set
|Locale::Codes::Country/dom> identified with the symbol C<LOCALE_CODE_DOM>.

=head3 C<CountryName['dom']>

An alias of L<C<CountryName['domain']>|/CountryName['domain']>.

=head1 CLASS CONSTANTS

These class L<constant>s are for B<internal use only>.

=over 4

=item C<CANONICAL_CODE_SET_OF>

It is a hash reference which contains pairs of alias to canonical name of
L<code sets of countries|Locale::Codes::Country/SUPPORTED CODE SETS>.

=item C<CONVERTER>

It is a hash reference which contains pairs of alias to subroutine references
of L<converters of countries|Locale::Codes::Country/ROUTINES>.

=item C<LOCALE_TYPE>

It is a string which was used by error messages.

=back

=head1 EXPORTS

These type constraints are not exported by default but you can request them in
an import list like this:

    use MooseX::Types::Locale::Codes::Country qw(
        CountryCode
        CountryName
    );

=head1 NOTES

=head2 Aliases of Country will be Canonized

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

This module was previously known as L<MooseX::Types::Locale::Country>.

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

L<Locale::Codes::Country>

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
