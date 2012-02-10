package MooseX::Types::Locale::Codes::LanguageVariation;


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

use MooseX::Types -declare => [qw(LanguageVariationCode LanguageVariationName)];
use MooseX::Types::Moose qw(Maybe Str);
use MooseX::Types::Parameterizable 0.07 qw(Parameterizable); ### TODO: 0.09

# ==============================================================================
# General Module(s)
# ==============================================================================

use Locale::Codes::LangVar 3.20 qw();

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
};

use constant CONVERTER => {
    code_to_code => \&Locale::Codes::LangVar::langvar_code2code,
    code_to_name => \&Locale::Codes::LangVar::code2langvar,
    name_to_code => \&Locale::Codes::LangVar::langvar2code,
};

use constant LOCALE_TYPE => 'language variation';


# ******************************************************************************
# Type Constraint(s) and Coercion(s)
# ******************************************************************************

# ==============================================================================
# Language Variation Code
# ==============================================================================

subtype LanguageVariationCode,
    as Parameterizable[Str, Maybe[Str]],
        where {
            return __PACKAGE__->validate_code(@_);
        },
        message {
            return __PACKAGE__->message_for_code('LanguageVariationCode', @_);
        };

coerce LanguageVariationCode,
    from Str,
        via {
            return __PACKAGE__->coerce_code(@_);
        };

# ==============================================================================
# Language Variation Name
# ==============================================================================

subtype LanguageVariationName,
    as Parameterizable[Str, Maybe[Str]],
        where {
            return __PACKAGE__->validate_name(@_);
        },
        message {
            return __PACKAGE__->message_for_name('LanguageVariationName', @_);
        };

coerce LanguageVariationName,
    from Str,
        via {
            return __PACKAGE__->coerce_name(@_);
        };


# ******************************************************************************
# Optionally Add Getopt Option Type
# ******************************************************************************

__PACKAGE__->add_option_type_to_map(
    LanguageVariationCode,
    LanguageVariationName,
);


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

MooseX::Types::Locale::Codes::LanguageVariation - Locale::Codes::LangVar related type constraints and coercions for Moose

=head1 VERSION

This document describes L<MooseX::Types::Locale::Codes::LanguageVariation>
version C<0.00>.

=head1 SYNOPSIS

    {
        package MyApp::Locale::LanguageVariation;

        use Moose;
        use MooseX::Types::Locale::Codes::LanguageVariation qw(
            LanguageVariationCode
            LanguageVariationName
        );

        has 'code' => (isa => LanguageVariationCode, coerce => 1, is => 'rw');
        has 'name' => (isa => LanguageVariationName, coerce => 1, is => 'rw');

        __PACKAGE__->meta->make_immutable;
    }

    my $language_variation = MyApp::Locale::LanguageVariation->new(
        code => 'VALENCIA',
        name => 'VALENCIAN',
    );
    print $language_variation->code; # 'valencia'  (letter case was canonized)
    print $language_variation->name; # 'Valencian' (letter case was canonized)

=head1 DESCRIPTION

This module packages several L<parameterizable|MooseX::Types::Parameterizable>
L<type constraints|Moose::Meta::TypeConstraint> and L<coercions
|Moose::Meta::TypeCoercion> for L<Moose>.
They were designed to work with the suite of codes and names from
L<Locale::Codes::LangVar>.
The parameters correspond to L<code sets of language variations
|Locale::Codes::LangVar/SUPPORTED CODE SETS>.

It is a part of L<MooseX::Types::Locale::Codes>.

=head1 TYPE CONSTRAINTS AND COERCIONS

=head2 LanguageVariationCode[`a]

=head3 C<LanguageVariationCode>

An alias of L<C<LanguageVariationCode['alpha']>
|/LanguageVariationCode['alpha']>.

=head3 C<LanguageVariationCode['alpha']>

A subtype of C<Str>, which should be defined in B<case sensitive> language
variation code of IANA Language Subtag Registry.
For example, it allows not C<'Scotland'> but C<'scotland'> as
C<'Scottish Standard English'>.

If you turned C<coerce> option on, C<Str> will be canonical case.
For example, C<'Scotland'> will convert to C<'scotland'>.

The parameter corresponds to L<C<alpha> language variation code set
|Locale::Codes::LangVar/alpha> identified with the symbol
C<LOCALE_LANGVAR_ALPHA>.

=head2 LanguageVariationName[`a]

=head3 C<LanguageVariationName>

An alias of L<C<LanguageVariationName['alpha']>
|/LanguageVariationName['alpha']>.

=head3 C<LanguageVariationName['alpha']>

A subtype of C<Str>, which should be defined in B<case sensitive> language
variation name of IANA Language Subtag Registry.
For example, it allows not C<'Hepburn Romanization'> but
C<'Hepburn romanization'> as C<'hepburn'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'Hepburn Romanization'> will convert to
C<'Hepburn romanization'> and C<'Boni dialect'> will convert to
C<'Aluku dialect'>.

The parameter corresponds to L<C<alpha> language variation code set
|Locale::Codes::LangVar/alpha> identified with the symbol
C<LOCALE_LANGVAR_ALPHA>.

=head1 CLASS CONSTANTS

These class L<constant>s are for B<internal use only>.

=over 4

=item C<CANONICAL_CODE_SET_OF>

It is a hash reference which contains pairs of alias to canonical name of
L<code sets of language variations|Locale::Codes::LangVar/SUPPORTED CODE SETS>.

=item C<CONVERTER>

It is a hash reference which contains pairs of alias to subroutine references
of L<converters of language variations|Locale::Codes::LangVar/ROUTINES>.

=item C<LOCALE_TYPE>

It is a string which was used by error messages.

=back

=head1 EXPORTS

These type constraints are not exported by default but you can request them in
an import list like this:

    use MooseX::Types::Locale::Codes::LanguageVariation qw(
        LanguageVariationCode
        LanguageVariationName
    );

=head1 NOTES

=head2 Aliases of Language Variation will be Canonized

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

L<Locale::Codes::LangVar>

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
