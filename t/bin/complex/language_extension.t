use strict;
use warnings;

use Test::Requires {
    '5.010_001'                    => 0,
    'Data::Validator'              => 0,
    'MooseX::Types::LoadableClass' => 0,
};

use lib 't/lib';
use Test::MooseX::Types::Locale::Codes::LanguageExtension::Complex;

Test::MooseX::Types::Locale::Codes::LanguageExtension::Complex->run_tests;

__END__
