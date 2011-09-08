use strict;
use warnings;

use Test::More;
use Test::NoWarnings;

my @modules = qw(
    MooseX::Types::Locale::Codes::Country
    MooseX::Types::Locale::Codes::Currency
    MooseX::Types::Locale::Codes::Language
    MooseX::Types::Locale::Codes::LanguageExtension
    MooseX::Types::Locale::Codes::LanguageVariation
    MooseX::Types::Locale::Codes::Script
);

plan tests => scalar @modules + 1;

foreach my $module (@modules) {
    use_ok($module);
}

__END__
