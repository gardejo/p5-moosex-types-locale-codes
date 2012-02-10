# ******************************************************************************
# Dependency(-ies)
# ******************************************************************************

use inc::Module::Install 1.01;
use Module::Install::AuthorRequires;
use Module::Install::AuthorTests;


# ******************************************************************************
# Gathering Meta Information
# ******************************************************************************

# ==============================================================================
# Individual Gathering
# ==============================================================================

author(
    'MORIYA Masaki, alias Gardejo <moriya at cpan dot org>',
);
resources(
    repository
        => 'git://github.com/gardejo/p5-moosex-types-locale-codes.git',
    # (implicit assignment)
    # bugtracker
    #     => 'https://rt.cpan.org/Public/Dist/Display.html?Name='
    #      . 'MooseX-Types-Locale-Codes',
    homepage
        => 'https://github.com/gardejo/p5-moosex-types-locale-codes',
);

# ==============================================================================
# The Rest of Information
# ==============================================================================

# name, module_name, abstract, version, perl_version(5.008_001), license
all_from(
    'lib/MooseX/Types/Locale/Codes.pm'
);


# ******************************************************************************
# Definition of Dependency(-ies)
# ******************************************************************************

# ==============================================================================
# General Dependency(-ies)
# ==============================================================================

requires(
#   'Carp'                              => '0',
        # is included by perl 5
#   'Devel::PartialDump'                => '0.13',
        # is depended on by MooseX-Types-Parameterizable
    'Locale::Codes'                     => '3.20',
        # for new locales and namespace reorganization and new codeset API
    'Moose'                             => '1.06',
        # MooseX-Types depends on Moose 1.06+
    'MooseX::Types'                     => '0.19',
#   'MooseX::Types::Moose'              => '0.19',
        # is included by MooseX-Types
    'MooseX::Types::Parameterizable'    => '0.07', ### TODO: 0.08
        # for correct coercion with modern Moose (2.0100-TRIAL +)
#   'Scalar::Util'                      => '1.19',
        # is depended on by Moose
#   'Try::Tiny'                         => '0.02',
        # is depended on by Moose
#   'constant'                          => '0',
        # is included by perl 5.004
    'namespace::autoclean'              => '0',
    'parent'                            => '0',
);

# ==============================================================================
# Optional dependency(-ies)
# ==============================================================================

features(
    'Option Types for MooseX::Getopt' => [
        -default => 0,
        recommends(
            'MooseX::Getopt'                    => '0',
        ),
    ],
);

# ==============================================================================
# Build Dependency(-ies)
# ==============================================================================

# build_requires(
# );

# ==============================================================================
# Test Dependency(-ies)
# ==============================================================================

test_requires(
#   'perl'                              => '5.010_001',
#   'Data::Validator'                   => '0',
#   'MooseX::Types::LoadableClass'      => '0',
    'Test::Able'                        => '0',
#   'Test::Class'                       => '0.34',
    'Test::Fatal'                       => '0',
    'Test::More'                        => '0',
#   'Test::More'                        => '0.87_01',
        # for done_testing()
    'Test::NoWarnings'                  => '0',
    'Test::Requires'                    => '0',
    'Test::Warn'                        => '0',
);

# ==============================================================================
# Install Dependency(-ies)
# ==============================================================================

# install_requires(
# );

# ==============================================================================
# Author Dependency(-ies) : Module::Install::AuthorRequires
# ==============================================================================

author_requires(
    'Module::Install::AuthorRequires'   => '0',
    'Module::Install::AuthorTests'      => '0',
    'Perl::Critic'                      => '0.094',
        # for "equivalent_modules" parameter
    'Test::CPAN::Meta'                  => '0.12',
        # for spec version 1.4
#   'Test::CheckChanges'                => '0',
        # cannot be installed in Win32
    'Test::DistManifest'                => '0',
    'Test::HasVersion'                  => '0',
#   'Test::Kwalitee'                    => '0',
        # is always die (but it was used by xt/bin/distribution/kwalitee.t)
    'Test::MinimumVersion'              => '0',
    'Test::Mojibake'                    => '0',
    'Test::NoTabs'                      => '0',
    'Test::Perl::Critic'                => '0',
    'Test::Pod'                         => '1.40',
        # is vaguely modern version
    'Test::Pod::Coverage'               => '0.08',
        # for all_pod_coverage_ok()
    'Test::Pod::LinkCheck'              => '0',
    'Test::Portability::Files'          => '0',
#   'Test::Spelling'                    => '0',
        # is hard to be used in Win32
    'Test::Synopsis'                    => '0',
    'Test::UseAllModules'               => '0.12',
        # for "under" option and cooperation with Test::NoWarnings
    'Test::Vars'                        => '0',
);


# ******************************************************************************
# Test(s)
# ******************************************************************************

# ==============================================================================
# General Test(s)
# ==============================================================================

tests_recursive('t');

# ==============================================================================
# Author Test(s) : Module::Install::AuthorTests
# ==============================================================================

recursive_author_tests('xt');


# ******************************************************************************
# Installation
# ******************************************************************************

# auto_install;
    # 'auto_install' is deprecated


# ******************************************************************************
# Writter
# ******************************************************************************

WriteAll;
