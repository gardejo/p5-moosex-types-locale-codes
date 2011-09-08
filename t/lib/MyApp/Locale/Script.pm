package MyApp::Locale::Script;

use namespace::autoclean;

use Moose;

use MooseX::Types::Locale::Codes::Script qw(
    ScriptCode
    ScriptName
);

has 'code' => (
    isa         => ScriptCode['alpha'],
        # same as : isa => ScriptCode
    is          => 'rw',
);

has 'name' => (
    isa         => ScriptName['alpha'],
        # same as : isa => ScriptName
    is          => 'rw',
);

__PACKAGE__->meta->make_immutable;

1;
__END__
