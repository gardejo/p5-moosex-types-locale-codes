package MooseX::Types::Locale::Codes;


# ******************************************************************************
# Dependency(-ies)
# ******************************************************************************

# ==============================================================================
# Pragma(ta)
# ==============================================================================

use 5.008_001;
use strict;
use warnings;


# ******************************************************************************
# Class Constant(s) and Variable(s)
# ******************************************************************************

our $VERSION = '0.00';
our $AUTHORITY = 'cpan:MORIYA';


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

MooseX::Types::Locale::Codes - Locale::Codes related type constraints and coercions for Moose

=head1 VERSION

This document describes L<MooseX::Types::Locale::Codes> version C<0.00>.

=head1 SYNOPSIS

    {
        package MyApp::Locale;

        use Moose;
        use MooseX::Types::Locale::Codes::Country  qw(CountryCode);
        use MooseX::Types::Locale::Codes::Currency qw(CurrencyCode);
        use MooseX::Types::Locale::Codes::Language qw(LanguageCode);
        use MooseX::Types::Locale::Codes::Script   qw(ScriptCode);

        has 'country'  => (isa => CountryCode,  coerce => 1, is => 'ro');
        has 'currency' => (isa => CurrencyCode, coerce => 1, is => 'ro');
        has 'language' => (isa => LanguageCode, coerce => 1, is => 'ro');
        has 'script'   => (isa => ScriptCode,   coerce => 1, is => 'ro');
        # See each modules for further type constraints and coercions.

        __PACKAGE__->meta->make_immutable;
    }

    my $locale = MyApp::Locale->new(
        country  => 'US',
        currency => 'usd',
        language => 'EN',
        script   => 'latn',
    );
    print $locale->country;  # 'us'   (letter case was canonized)
    print $locale->currency; # 'USD'  (letter case was canonized)
    print $locale->language; # 'en'   (letter case was canonized)
    print $locale->script;   # 'Latn' (letter case was canonized)

=head1 DESCRIPTION

This distribution contains some modules which package several
L<parameterizable|MooseX::Types::Parameterizable> L<type constraints
|Moose::Meta::TypeConstraint> and L<coercions|Moose::Meta::TypeCoercion> for
L<Moose>.
They were designed to work with the suite of codes and names from
L<Locale::Codes>.
The parameters correspond to each code sets.

=head1 MODULES

Currently, the following modules are included.

=head2 L<MooseX::Types::Locale::Codes::Country>

The following parameterizable type constraints were designed to work with the
suite of codes and names from L<Locale::Codes::Country>.
The parameters correspond to L<code sets of countries
|Locale::Codes::Country/SUPPORTED CODE SETS>.

=over 4

=item *

L<CountryCode[`a]|MooseX::Types::Locale::Codes::Country/CountryCode[`a]>

=item *

L<CountryName[`a]|MooseX::Types::Locale::Codes::Country/CountryName[`a]>

=back

=head3 Country{Code,Name}

An alias of L<Country{Code,Name}['alpha-2']|/Country{Code,Name}['alpha-2']>.

=head3 Country{Code,Name}['alpha-2']

The parameter corresponds to L<C<alpha-2> country code set
|Locale::Codes::Country/alpha-2> identified with the symbol
C<LOCALE_CODE_ALPHA_2>.

=head3 Country{Code,Name}['alpha2']

An alias of L<Country{Code,Name}['alpha-2']|/Country{Code,Name}['alpha-2']>.

=head3 Country{Code,Name}['alpha-3']

The parameter corresponds to L<C<alpha-3> country code set
|Locale::Codes::Country/alpha-3> identified with the symbol
C<LOCALE_CODE_ALPHA_3>.

=head3 Country{Code,Name}['alpha3']

An alias of L<Country{Code,Name}['alpha-3']|/Country{Code,Name}['alpha-3']>.

=head3 Country{Code,Name}['numeric']

The parameter corresponds to L<C<numeric> country code set
|Locale::Codes::Country/numeric> identified with the symbol
C<LOCALE_CODE_NUMERIC>.

=head3 Country{Code,Name}['num']

An alias of L<Country{Code,Name}['numeric']|/Country{Code,Name}['numeric']>.

=head3 Country{Code,Name}['fips-10']

The parameter corresponds to L<C<fips-10> country code set
|Locale::Codes::Country/fips-10> identified with the symbol
C<LOCALE_CODE_FIPS>.

=head3 Country{Code,Name}['fips10']

An alias of L<Country{Code,Name}['fips-10']|/Country{Code,Name}['fips-10']>.

=head3 Country{Code,Name}['fips']

An alias of L<Country{Code,Name}['fips-10']|/Country{Code,Name}['fips-10']>.

=head3 Country{Code,Name}['domain']

The parameter corresponds to L<C<dom> country code set
|Locale::Codes::Country/dom> identified with the symbol C<LOCALE_CODE_DOM>.

=head3 Country{Code,Name}['dom']

An alias of L<Country{Code,Name}['domain']|/Country{Code,Name}['domain']>.

=head2 L<MooseX::Types::Locale::Codes::Currency>

The following parameterizable type constraints were designed to work with the
suite of codes and names from L<Locale::Codes::Currency>.
The parameters correspond to L<code sets of currencies
|Locale::Codes::Currency/SUPPORTED CODE SETS>.

=over 4

=item *

L<CurrencyCode[`a]|MooseX::Types::Locale::Codes::Currency/CurrencyCode[`a]>

=item *

L<CurrencyName[`a]|MooseX::Types::Locale::Codes::Currency/CurrencyName[`a]>

=back

=head3 Currency{Code,Name}

An alias of L<Currency{Code,Name}['alpha']|/Currency{Code,Name}['alpha']>.

=head3 Currency{Code,Name}['alpha']

The parameter corresponds to L<C<alpha> currency code set
|Locale::Codes::Currency/alpha> identified with the symbol
C<LOCALE_CURR_ALPHA>.

=head3 Currency{Code,Name}['numeric']

The parameter corresponds to L<C<num> currency code set
|Locale::Codes::Currency/num> identified with the symbol
C<LOCALE_CURR_NUMERIC>.

=head3 Currency{Code,Name}['num']

An alias of L<Currency{Code,Name}['numeric']|/Currency{Code,Name}['numeric']>.

=head2 L<MooseX::Types::Locale::Codes::Language>

The following parameterizable type constraints were designed to work with the
suite of codes and names from L<Locale::Codes::Language>.
The parameters correspond to L<code sets of languages
|Locale::Codes::Language/SUPPORTED CODE SETS>.

=over 4

=item *

L<LanguageCode[`a]|MooseX::Types::Locale::Codes::Language/LanguageCode[`a]>

=item *

L<LanguageName[`a]|MooseX::Types::Locale::Codes::Language/LanguageName[`a]>

=back

=head3 Language{Code,Name}

An alias of L<Language{Code,Name}['alpha-2']|/Language{Code,Name}['alpha-2']>.

=head3 Language{Code,Name}['alpha-2']

The parameter corresponds to L<C<alpha-2> language code set
|Locale::Codes::Language/alpha-2> identified with the symbol
C<LOCALE_LANG_ALPHA_2>.

=head3 Language{Code,Name}['alpha2']

An alias of L<Language{Code,Name}['alpha-2']|/Language{Code,Name}['alpha-2']>.

=head3 Language{Code,Name}['alpha-3']

The parameter corresponds to L<C<alpha-3> language code set
|Locale::Codes::Language/alpha-3> identified with the symbol
C<LOCALE_LANG_ALPHA_3>.

=head3 Language{Code,Name}['alpha3']

An alias of L<Language{Code,Name}['alpha-3']|/Language{Code,Name}['alpha-3']>.

=head3 Language{Code,Name}['bibliographic']

An alias of L<Language{Code,Name}['alpha-3']|/Language{Code,Name}['alpha-3']>.

=head3 Language{Code,Name}['terminologic']

The parameter corresponds to L<C<term> language code set
|Locale::Codes::Language/term> identified with the symbol C<LOCALE_LANG_TERM>.

=head3 Language{Code,Name}['term']

An alias of L<Language{Code,Name}['terminologic']
|/Language{Code,Name}['terminologic']>.

=head2 L<MooseX::Types::Locale::Codes::LanguageExtension>

The following parameterizable type constraints were designed to work with the
suite of codes and names from L<Locale::Codes::LangExt>.
The parameters correspond to L<code sets of language extensions
|Locale::Codes::LangExt/SUPPORTED CODE SETS>.

=over 4

=item *

L<LanguageExtensionCode[`a]
|MooseX::Types::Locale::Codes::LanguageExtension/LanguageExtensionCode[`a]>

=item *

L<LanguageExtensionName[`a]
|MooseX::Types::Locale::Codes::LanguageExtension/LanguageExtensionName[`a]>

=back

=head3 LanguageExtension{Code,Name}

An alias of L<LanguageExtension{Code,Name}['alpha']
|/LanguageExtension{Code,Name}['alpha']>.

=head3 LanguageExtension{Code,Name}['alpha']

The parameter corresponds to L<C<alpha> language extension code set
|Locale::Codes::LangExt/alpha> identified with the symbol
C<LOCALE_LANGEXT_ALPHA>.

=head2 L<MooseX::Types::Locale::Codes::LanguageVariation>

The following parameterizable type constraints were designed to work with the
suite of codes and names from L<Locale::Codes::LangVar>.
The parameters correspond to L<code sets of language variations
|Locale::Codes::LangVar/SUPPORTED CODE SETS>.

=over 4

=item *

L<LanguageVariationCode[`a]
|MooseX::Types::Locale::Codes::LanguageVariation/LanguageVariationCode[`a]>

=item *

L<LanguageVariationName[`a]
|MooseX::Types::Locale::Codes::LanguageVariation/LanguageVariationName[`a]>

=back

=head3 LanguageVariation{Code,Name}

An alias of L<LanguageVariation{Code,Name}['alpha']
|/LanguageVariation{Code,Name}['alpha']>.

=head3 LanguageVariation{Code,Name}['alpha']

The parameter corresponds to L<C<alpha> language variation code set
|Locale::Codes::LangVar/alpha> identified with the symbol
C<LOCALE_LANGVAR_ALPHA>.

=head2 L<MooseX::Types::Locale::Codes::Script>

The following parameterizable type constraints were designed to work with the
suite of codes and names from L<Locale::Codes::Script>.
The parameters correspond to L<code sets of scripts
|Locale::Codes::Script/SUPPORTED CODE SETS>.

=over 4

=item *

L<ScriptCode[`a]|MooseX::Types::Locale::Codes::Script/ScriptCode[`a]>

=item *

L<ScriptName[`a]|MooseX::Types::Locale::Codes::Script/ScriptName[`a]>

=back

=head3 Script{Code,Name}

An alias of L<Script{Code,Name}['alpha']|/Script{Code,Name}['alpha']>.

=head3 Script{Code,Name}['alpha']

The parameter corresponds to L<C<alpha> script code set
|Locale::Codes::Script/alpha> identified with the symbol
C<LOCALE_SCRIPT_ALPHA>.

=head3 Script{Code,Name}['numeric']

The parameter corresponds to L<C<numeric> script code set
|Locale::Codes::Script/numeric> identified with the symbol
C<LOCALE_SCRIPT_NUMERIC>.

=head3 Script{Code,Name}['num']

An alias of L<Script{Code,Name}['numeric']|/Script{Code,Name}['numeric']>.

=head1 NOTES

=head2 Aliases of Locale will be Canonized

L<Aliases of name|Locale::Codes/COMMON ALIASES> on each locales do not satisfy
with type constraints.

    my $alias = 'Old English (ca. 450-1100)';
    my $is_valid = LanguageName['alpha-3']->check($alias);
    # $is_valid is false (it is not what you had expected), but
    my $code = Locale::Codes::Language::language2code($alias, 'alpha3');
    # $code is 'ang'.

Therefore, a type coercion provides the canonical name for you.

    my $name = LanguageName['alpha-3']->coerce($alias);
    # $name is 'English, Old (ca.450-1100)',
    # that is to say, it is not equal to $alias.

=head2 Behaviors of Coercions are Only Canonization

These type coercions are intended solely for B<canonization> of letter case,
aliased name or figures of numbers.
In other words, they B<do not convert> codes and names by L<C<XXX2code()>
|Locale::Codes::API/XXX2code ( NAME [,CODESET] )>, L<C<code2XXX()>
|Locale::Codes::API/code2XXX ( CODE [,CODESET] )> and L<C<XXX_code2code()>
|Locale::Codes::API/XXX_code2code ( CODE ,CODESET ,CODESET2 )> on
L<Locale::Codes::API>.

For example:

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

    my $language = MyApp::Locale::Language->new;
    print $language->code('EN');      # It is not 'English' but 'en'.
    print $language->name('english'); # It is not 'en' but 'English'.

If you want conversion, could you implement an individual locale class (with
several attributes and L<Data::Validator>) ?

    {
        package MyApp::Locale::Language::Complex;

        use 5.010_001;
        use Moose;
        extends qw(MyApp::Locale::Language);
        use Data::Validator;
        use Locale::Codes::Language;

        has '+code' => (lazy_build => 1, trigger => sub { $_[0]->clear_name });
        has '+name' => (lazy_build => 1, trigger => sub { $_[0]->clear_code });

        around BUILDARGS => sub {
            state $rule = Data::Validator->new(
                code => { xor => [qw(name)], optional => 1 },
                name => { xor => [qw(code)], optional => 1 },
            )->with('Method');
            my ($next, $class, $init_args) = (shift, $rule->validate(@_));
            return $class->$next($init_args);
        };

        sub _build_code {
            confess 'Language name was not specified'
                unless $_[0]->has_name;
            return language2code($_[0]->name);
        }

        sub _build_name {
            confess 'Language code was not specified'
                unless $_[0]->has_code;
            return code2language($_[0]->code);
        }

        __PACKAGE__->meta->make_immutable;
    }

    use Try::Tiny;

    my $language = MyApp::Locale::Language::Complex->new(code => 'EN');
    print $language->code;       # 'en'        (was canonized by coercion)
    print $language->name;       # 'English'   (was generated by builder)
    print $language->code('EO'); # 'eo'        (was canonized by coercion)
    print $language->name;       # 'Esperanto' (was generated by builder)

    try {
        MyApp::Locale::Language::Complex->new(code => 'en', name => 'English');
    }
    catch {
        print $_; # Exclusive parameters passed togther: 'code' v.s. 'name'...
    };

Or, use a different solution (with L<MooseX::Attribute::Dependent>):

    {
        package MyApp::Locale::Language::AlternativeComplex;

        use Moose;
        use MooseX::Types::Locale::Codes::Language qw(
            LanguageCode
            LanguageName
        );
        use MooseX::Attribute::Dependent;
        use Locale::Codes::Language;

        # Note: 'dependency' option cannot exist in inherited attributes.
        has 'code' => (isa => LanguageCode, coerce => 1, is => 'rw',
                       dependency => None['name']);
        has 'name' => (isa => LanguageName, coerce => 1, is => 'rw',
                       dependency => None['code']);

        # Note: trigger is too late (it is same as after).
        before code => sub { $_[0]->clear_name if defined $_[1] };
        before name => sub { $_[0]->clear_code if defined $_[1] };

        sub _build_code {
            confess 'Language name was not specified'
                unless $_[0]->has_name;
            return language2code($_[0]->name);
        }

        sub _build_name {
            confess 'Language code was not specified'
                unless $_[0]->has_code;
            return code2language($_[0]->code);
        }

        __PACKAGE__->meta->make_immutable;
    }

    use Try::Tiny;

    # ...

    try {
        MyApp::Locale::Language::AlternativeComplex->new
            (code => 'en', name => 'English');
    }
    catch {
        print $_; # None of the following attributes can have a value: name...
    };

=head2 Option Types for L<MooseX::Getopt>

These modules provide you the optional type mappings for L<MooseX::Getopt>
when it was installed in your system.
Then you can use the option types for L<Getopt::Long> without your handmaid
type mappings.

    {
        package MyApp::Locale::Language::WithOption;

        use Moose;

        use MooseX::Types::Locale::Codes::Language qw(
            LanguageCode
            LanguageName
        );
        with qw(
            MooseX::Getopt
        );

        has 'code' => (isa => LanguageCode, coerce => 1, is => 'rw');
        has 'name' => (isa => LanguageName, coerce => 1, is => 'rw');

        __PACKAGE__->meta->make_immutable;
    }

    local @ARGV = ('--code', 'en', '--name', 'English');
    my $language = MyApp::Locale::Language::WithOption->new_with_options;
    print $language->code; # 'en'
    print $language->name; # 'English'

All types are assigned to C<String> (C<"=s">) option types.
Maybe only a minority of types should assigned to C<Integer> (C<"=i">) types,
however as it is at present.

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

=item *

L<Locale::Codes::Currency>

=item *

L<Locale::Codes::Language>

=item *

L<Locale::Codes::LangExt>

=item *

L<Locale::Codes::LangVar>

=item *

L<Locale::Codes::Script>

=back

=head1 INCOMPATIBILITIES

None reported.

Note that L<MooseX::Types::Locale::Language> and
L<MooseX::Types::Locale::Country> which become the predecessors of
L<MooseX::Types::Locale::Codes::Language> and
L<MooseX::Types::Locale::Codes::Country> are deprecated.
The original two modules will continue to work, but all new type constraints
and coercions will be added in the C<MooseX::Types::Locale::Codes> namespace.

Also L<MooseX::Types::Locale::Language::Fast> and
L<MooseX::Types::Locale::Country::Fast> which do not provide coercions
to save memory footprint and to quicken initialization will continue to work
too, but the original two modules now provide coercions.
Because these variations can easily be ignored.

=head1 TO DO

=over 4

=item *

Increasing tests.

=item *

Decreasing dependencies (if possible).

=back

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

=head2 Making Suggestions and Reporting Bugs

Please report any found bugs, feature requests, and ideas for improvements to
C<bug-moosex-types-locale-codes at rt.cpan.org>,
or through the web interface at
L<https://rt.cpan.org/Public/Dist/Display.html?Name=MooseX-Types-Locale-Codes>.
I will be notified, and then you'll automatically be notified of progress
on your bugs/requests as I make changes.

When reporting bugs, if possible, please add as small a sample as you can make
of the code that produces the bug.
And of course, suggestions and patches are welcome.

=head1 SUPPORT

You can find documentation for this module with the C<perldoc> command.

    perldoc MooseX::Types::Locale::Codes

You can also look for information at:

=over 4

=item RT: CPAN's request tracker

L<https://rt.cpan.org/Public/Dist/Display.html?Name=MooseX-Types-Locale-Codes>

=item MetaCPAN: An up and coming search engine for CPAN things

L<https://metacpan.org/release/MooseX-Types-Locale-Codes>

=item CPAN Search: A traditional search engine for CPAN things

L<http://search.cpan.org/dist/MooseX-Types-Locale-Codes>

=item AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/MooseX-Types-Locale-Codes>

=item CPAN Ratings: Public reviews of CPAN distributions

L<http://cpanratings.perl.org/dist/MooseX-Types-Locale-Codes>

=item GitHub: A social coding site where you can get the source code

L<https://github.com/gardejo/p5-moosex-types-locale-codes>

=back

=head1 VERSION CONTROL

This module is maintained using I<Git>.
You can get the latest version from
L<git://github.com/gardejo/p5-moosex-types-locale-codes.git>.

=head1 DLSIP STATUS

DLSIP (a.k.a. DSLIP) stands for B<D>evelopment Stage, B<L>anguage Used,
B<S>upport Level, B<I>nterface Style and B<P>ublic License.
See L<http://search.cpan.org/dlsip> for further information.
This distribution is C<Rpdrp> (L<http://search.cpan.org/dlsip?Rpdrp>).

=over 4

=item D - Development Stage

R - Released

=item L - Language Used

p - Perl-only, no compiler needed, should be platform independent

=item S - Support Level

d - Developer

=item I - Interface Style

r - some use of unblessed L<References|perlref> or L<ties|perltie>

=item P - Public License

p - Standard-Perl: user may choose between L<GPL|perlgpl> and L<Artistic
|perlartistic>

=back

=head1 ACKNOWLEDGEMENTS

=over 4

=item *

All of inhabitants of L<Moose> ecosystem.

=item *

B<Canon Research Centre Europe>, B<Michael Hennecke>, B<Neil Bowers> (neilb)
and B<Sullivan Beck> (sbeck) wrote L<Locale::Codes>, which this module uses.

=item *

B<John Napiorkowski> (jjnapiork) was interested in my humble report that
L<MooseX::Types::Parameterizable> works incompletely with recent version of
L<Moose>.

=item *

B<Shawn M Moore> (sartak) enlightened me as I<coercion> can also be used as a
countable noun in L<Moose> context.

=item *

B<Jeffrey Ryan Thalhammer> (thaljef) enlightened me as a correct usage of
L<Perl::Critic>.

=back

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
