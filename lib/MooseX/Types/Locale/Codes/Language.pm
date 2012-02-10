package MooseX::Types::Locale::Codes::Language;


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

use MooseX::Types -declare => [qw(LanguageCode LanguageName)];
use MooseX::Types::Moose qw(Maybe Str);
use MooseX::Types::Parameterizable 0.07 qw(Parameterizable); ### TODO: 0.09

# ==============================================================================
# General Module(s)
# ==============================================================================

use Locale::Codes::Language 3.20 qw();

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
    'alpha2'        => 'alpha-2',
    'alpha3'        => 'alpha-3',
    'bibliographic' => 'alpha-3',
    'default'       => 'alpha-2',
    'terminologic'  => 'term',
};

use constant CONVERTER => {
    code_to_code => \&Locale::Codes::Language::language_code2code,
    code_to_name => \&Locale::Codes::Language::code2language,
    name_to_code => \&Locale::Codes::Language::language2code,
};

use constant LOCALE_TYPE => 'language';


# ******************************************************************************
# Type Constraint(s) and Coercion(s)
# ******************************************************************************

# ==============================================================================
# Language Code
# ==============================================================================

subtype LanguageCode,
    as Parameterizable[Str, Maybe[Str]],
        where {
            return __PACKAGE__->validate_code(@_);
        },
        message {
            return __PACKAGE__->message_for_code('LanguageCode', @_);
        };

coerce LanguageCode,
    from Str,
        via {
            return __PACKAGE__->coerce_code(@_);
        };

# ==============================================================================
# Language Name
# ==============================================================================

subtype LanguageName,
    as Parameterizable[Str, Maybe[Str]],
        where {
            return __PACKAGE__->validate_name(@_);
        },
        message {
            return __PACKAGE__->message_for_name('LanguageName', @_);
        };

coerce LanguageName,
    from Str,
        via {
            return __PACKAGE__->coerce_name(@_);
        };


# ******************************************************************************
# Optionally Add Getopt Option Type
# ******************************************************************************

__PACKAGE__->add_option_type_to_map(
    LanguageCode,
    LanguageName,
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

MooseX::Types::Locale::Codes::Language - Locale::Codes::Language related type constraints and coercions for Moose

=head1 VERSION

This document describes L<MooseX::Types::Locale::Codes::Language> version
C<0.00>.

=head1 SYNOPSIS

    {
        package MyApp::Locale::Language;

        use Moose;
        use MooseX::Types::Locale::Codes::Language qw(
            LanguageCode
            LanguageName
        );

        has 'code' => (isa => LanguageCode, coerce => 1, is => 'rw');
        has 'name' => (isa => LanguageName, coerce => 1, is => 'rw');

        __PACKAGE__->meta->make_immutable;
    }

    my $language = MyApp::Locale::Language->new(
        code => 'EN',
        name => 'ENGLISH',
    );
    print $language->code; # 'en'      (letter case was canonized)
    print $language->name; # 'English' (letter case was canonized)

=head1 DESCRIPTION

This module packages several L<parameterizable|MooseX::Types::Parameterizable>
L<type constraints|Moose::Meta::TypeConstraint> and L<coercions
|Moose::Meta::TypeCoercion> for L<Moose>.
They were designed to work with the suite of codes and names from
L<Locale::Codes::Language>.
The parameters correspond to L<code sets of languages
|Locale::Codes::Language/SUPPORTED CODE SETS>.

It is a part of L<MooseX::Types::Locale::Codes>.

=head1 TYPE CONSTRAINTS AND COERCIONS

=head2 LanguageCode[`a]

=head3 C<LanguageCode>

An alias of L<C<LanguageCode['alpha-2']>|/LanguageCode['alpha-2']>.

=head3 C<LanguageCode['alpha-2']>

A subtype of C<Str>, which should be defined in B<case sensitive> language code
of ISO 639-1 alpha-2.
For example, it allows not C<'JA'> but C<'ja'> as C<'Japanese'>.

If you turned C<coerce> option on, C<Str> will be lower-case.
For example, C<'JA'> will convert to C<'ja'>.

The parameter corresponds to L<C<alpha-2> language code set
|Locale::Codes::Language/alpha-2> identified with the symbol
C<LOCALE_LANG_ALPHA_2>.

=head3 C<LanguageCode['alpha2']>

An alias of L<C<LanguageCode['alpha-2']>|/LanguageCode['alpha-2']>.

=head3 C<LanguageCode['alpha-3']>

A subtype of C<Str>, which should be defined in B<case sensitive> language code
of ISO 639-2/B alpha-3.
For example, it allows not C<'GER'> but C<'ger'> as C<'German'>.

If you turned C<coerce> option on, C<Str> will be lower-case.
For example, C<'GER'> will convert to C<'ger'>.

The parameter corresponds to L<C<alpha-3> language code set
|Locale::Codes::Language/alpha-3> identified with the symbol
C<LOCALE_LANG_ALPHA_3>.

=head3 C<LanguageCode['alpha3']>

An alias of L<C<LanguageCode['alpha-3']>|/LanguageCode['alpha-3']>.

=head3 C<LanguageCode['bibliographic']>

An alias of L<C<LanguageCode['alpha-3']>|/LanguageCode['alpha-3']>.

=head3 C<LanguageCode['terminologic']>

A subtype of C<Str>, which should be defined in B<case sensitive> language code
of ISO 639-2/T alpha-3.
For example, it allows not C<'DEU'> but C<'deu'> as C<'German'>.

If you turned C<coerce> option on, C<Str> will be lower-case.
For example, C<'DEU'> will convert to C<'deu'>.

The parameter corresponds to L<C<term> language code set
|Locale::Codes::Language/term> identified with the symbol C<LOCALE_LANG_TERM>.

=head3 C<LanguageCode['term']>

An alias of L<C<LanguageCode['terminologic']>|/LanguageCode['terminologic']>.

=head2 LanguageName[`a]

=head3 C<LanguageName>

An alias of L<C<LanguageName['alpha-2']>|/LanguageName['alpha-2']>.

=head3 C<LanguageName['alpha-2']>

A subtype of C<Str>, which should be defined in B<case sensitive> language name
of ISO 639-1.
For example, it allows not C<'ESPERANTO'> but C<'Esperanto'> as C<'eo'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'ESPERANTO'> will convert to C<'Esperanto'> and C<'Valencian'>
will convert to C<'Catalan'>.

The parameter corresponds to L<C<alpha-2> language code set
|Locale::Codes::Language/alpha-2> identified with the symbol
C<LOCALE_LANG_ALPHA_2>.

=head3 C<LanguageName['alpha2']>

An alias of L<C<LanguageName['alpha-2']>|/LanguageName['alpha-2']>.

=head3 C<LanguageName['alpha-3']>

A subtype of C<Str>, which should be defined in B<case sensitive> language name
of ISO 639-2/B alpha-3.
For example, it allows not C<'CHINESE'> but C<'Chinese'> as C<'chi'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'CHINESE'> will convert to C<'Chinese'> and C<'Low Saxon'> will
convert to C<'Low German'>.

The parameter corresponds to L<C<alpha-3> language code set
|Locale::Codes::Language/alpha-3> identified with the symbol
C<LOCALE_LANG_ALPHA_3>.

=head3 C<LanguageName['alpha3']>

An alias of L<C<LanguageName['alpha-3']>|/LanguageName['alpha-3']>.

=head3 C<LanguageName['bibliographic']>

An alias of L<C<LanguageName['alpha-3']>|/LanguageName['alpha-3']>.

=head3 C<LanguageName['terminologic']>

A subtype of C<Str>, which should be defined in B<case sensitive> language code
of ISO 639-2/T alpha-3.
For example, it allows not C<'CHINESE'> but C<'Chinese'> as C<'zho'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'CHINESE'> will convert to C<'Chinese'> and C<'Moldovan'> will
convert to C<'Romanian'>.

The parameter corresponds to L<C<term> language code set
|Locale::Codes::Language/term> identified with the symbol C<LOCALE_LANG_TERM>.

=head3 C<LanguageName['term']>

An alias of L<C<LanguageName['terminologic']>|/LanguageName['terminologic']>.

=head1 CLASS CONSTANTS

These class L<constant>s are for B<internal use only>.

=over 4

=item C<CANONICAL_CODE_SET_OF>

It is a hash reference which contains pairs of alias to canonical name of
L<code sets of languages|Locale::Codes::Language/SUPPORTED CODE SETS>.

=item C<CONVERTER>

It is a hash reference which contains pairs of alias to subroutine references
of L<converters of languages|Locale::Codes::Language/ROUTINES>.

=item C<LOCALE_TYPE>

It is a string which was used by error messages.

=back

=head1 EXPORTS

These type constraints are not exported by default but you can request them in
an import list like this:

    use MooseX::Types::Locale::Codes::Language qw(
        LanguageCode
        LanguageName
    );

=head1 NOTES

=head2 Aliases of Language will be Canonized

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

This module was previously known as L<MooseX::Types::Locale::Language>.

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

L<Locale::Codes::Language>

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
