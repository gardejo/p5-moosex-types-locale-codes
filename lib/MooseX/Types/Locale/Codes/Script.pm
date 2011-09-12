package MooseX::Types::Locale::Codes::Script;


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

use MooseX::Types -declare => [qw(ScriptCode ScriptName)];
use MooseX::Types::Moose qw(Maybe Str);
use MooseX::Types::Parameterizable 0.07 qw(Parameterizable); ### TODO: 0.08

# ==============================================================================
# General Module(s)
# ==============================================================================

use Locale::Codes::Script 3.17 qw();

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
    code_to_code => \&Locale::Codes::Script::script_code2code,
    code_to_name => \&Locale::Codes::Script::code2script,
    name_to_code => \&Locale::Codes::Script::script2code,
};

use constant LOCALE_TYPE => 'script';


# ******************************************************************************
# Type Constraint(s) and Coercion(s)
# ******************************************************************************

# ==============================================================================
# Script Code
# ==============================================================================

subtype ScriptCode,
    as Parameterizable[Str, Maybe[Str]],
        where {
            return __PACKAGE__->validate_code(@_);
        },
        message {
            return __PACKAGE__->message_for_code('ScriptCode', @_);
        };

coerce ScriptCode,
    from Str,
        via {
            return __PACKAGE__->coerce_code(@_);
        };

# ==============================================================================
# Script Name
# ==============================================================================

subtype ScriptName,
    as Parameterizable[Str, Maybe[Str]],
        where {
            return __PACKAGE__->validate_name(@_);
        },
        message {
            return __PACKAGE__->message_for_name('ScriptName', @_);
        };

coerce ScriptName,
    from Str,
        via {
            return __PACKAGE__->coerce_name(@_);
        };


# ******************************************************************************
# Optionally Add Getopt Option Type
# ******************************************************************************

if ( eval { require MooseX::Getopt } ) {
    MooseX::Getopt::OptionTypeMap->add_option_type_to_map($_, '=s')
        for (ScriptCode, ScriptName);
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

MooseX::Types::Locale::Codes::Script - Locale::Codes::Script related type constraints and coercions for Moose

=head1 VERSION

This document describes L<MooseX::Types::Locale::Codes::Script> version
C<0.00>.

=head1 SYNOPSIS

    {
        package MyApp::Locale::Script;

        use Moose;
        use MooseX::Types::Locale::Codes::Script qw(
            ScriptCode
            ScriptName
        );

        has 'code' => (isa => ScriptCode, coerce => 1, is => 'rw');
        has 'name' => (isa => ScriptName, coerce => 1, is => 'rw');

        __PACKAGE__->meta->make_immutable;
    }

    my $script = MyApp::Locale::Script->new(
        code => 'latn',
        name => 'latin',
    );
    print $script->code; # 'Latn'  (letter case was canonized)
    print $script->name; # 'Latin' (letter case was canonized)

=head1 DESCRIPTION

This module packages several L<parameterizable|MooseX::Types::Parameterizable>
L<type constraints|Moose::Meta::TypeConstraint> and L<coercions
|Moose::Meta::TypeCoercion> for L<Moose>.
They were designed to work with the suite of codes and names from
L<Locale::Codes::Script>.
The parameters correspond to L<code sets of scripts
|Locale::Codes::Script/SUPPORTED CODE SETS>.

It is a part of L<MooseX::Types::Locale::Codes>.

=head1 TYPE CONSTRAINTS AND COERCIONS

=head2 ScriptCode[`a]

=head3 C<ScriptCode>

An alias of L<C<ScriptCode['alpha']>|/ScriptCode['alpha']>.

=head3 C<ScriptCode['alpha']>

A subtype of C<Str>, which should be defined in B<case sensitive> script code
of ISO 15924.
For example, it allows not C<'latn'> but C<'Latn'> as C<'Latin'>.

If you turned C<coerce> option on, C<Str> will be canonical case.
For example, C<'latn'> will convert to C<'LATN'>.

The parameter corresponds to L<C<alpha> script code set
|Locale::Codes::Script/alpha> identified with the symbol
C<LOCALE_SCRIPT_ALPHA>.

=head3 C<ScriptCode['numeric']>

A subtype of C<Str>, which should be defined in numeric script code of ISO
15924.
For example, it allows not C<'70'> but C<'070'> as C<'Egyptian demotic'>.

If you turned C<coerce> option on, C<Str> will be canonical number.
For example, C<70> and C<'70'> will convert to C<'070'>.

The parameter corresponds to L<C<numeric> script code set
|Locale::Codes::Script/numeric> identified with the symbol
C<LOCALE_SCRIPT_NUMERIC>.

=head3 C<ScriptCode['num']>

An alias of L<C<ScriptCode['numeric']>|/ScriptCode['numeric']>.

=head2 ScriptName[`a]

=head3 C<ScriptName>

An alias of L<C<ScriptName['alpha']>|/ScriptName['alpha']>.

=head3 C<ScriptName['alpha']>

A subtype of C<Str>, which should be defined in B<case sensitive> script name
of ISO 15924.
For example, it allows not C<'hiragana'> but C<'Hiragana'> as C<'Hira'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'hiragana'> will convert to C<'Hiragana'> and C<'Harappan'> will
convert to C<'Indus'> (When version of L<Locale::Codes::Script> in your system
is C<3.17> or earlier, C<'Indus'> will convert to C<'Indus (Harappan)'>).

The parameter corresponds to L<C<alpha> script code set
|Locale::Codes::Script/alpha> identified with the symbol
C<LOCALE_SCRIPT_ALPHA>.

=head3 C<ScriptName['numeric']>

A subtype of C<Str>, which should be defined in B<case sensitive> script name
of ISO 15924.
For example, it allows not C<'Egyptian Demotic'> but C<'Egyptian demotic'> as
C<'070'>.

If you turned C<coerce> option on, C<Str> will be canonical (standard) name
from different letter case and/or aliased name.
For example, C<'Egyptian Demotic'> will convert to C<'Egyptian demotic'> and
C<'Han'> will convert to C<'Han (Hanzi, Kanji, Hanja)'>.

The parameter corresponds to L<C<numeric> script code set
|Locale::Codes::Script/numeric> identified with the symbol
C<LOCALE_SCRIPT_NUMERIC>.

=head3 C<ScriptName['num']>

An alias of L<C<ScriptName['numeric']>|/ScriptName['numeric']>.

=head1 CLASS CONSTANTS

These class L<constant>s are for B<internal use only>.

=over 4

=item C<CANONICAL_CODE_SET_OF>

It is a hash reference which contains pairs of alias to canonical name of
L<code sets of scripts|Locale::Codes::Script/SUPPORTED CODE SETS>.

=item C<CONVERTER>

It is a hash reference which contains pairs of alias to subroutine references
of L<converters of scripts|Locale::Codes::Script/ROUTINES>.

=item C<LOCALE_TYPE>

It is a string which was used by error messages.

=back

=head1 EXPORTS

These type constraints are not exported by default but you can request them in
an import list like this:

    use MooseX::Types::Locale::Codes::Script qw(
        ScriptCode
        ScriptName
    );

=head1 NOTES

=head2 Aliases of Script will be Canonized

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

L<Locale::Codes::Script>

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
