use strict;
use warnings;

use Test::Requires {
    'MooseX::Types::LoadableClass' => '0',
};

use lib 't/lib';
use Test::MooseX::Types::Locale::Codes::LanguageFamily::Constraint;

Test::MooseX::Types::Locale::Codes::LanguageFamily::Constraint->run_tests;

__END__
