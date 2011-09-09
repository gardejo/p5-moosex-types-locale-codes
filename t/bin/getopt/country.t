use strict;
use warnings;

use Test::Requires {
    'MooseX::Getopt'               => '0',
    'MooseX::Types::LoadableClass' => '0',
};

use lib 't/lib';
use Test::MooseX::Types::Locale::Codes::Country::Getopt;

Test::MooseX::Types::Locale::Codes::Country::Getopt->run_tests;

__END__
