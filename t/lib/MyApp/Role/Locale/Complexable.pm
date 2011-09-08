package MyApp::Role::Locale::Complexable;

use 5.010_001;

use Moose::Role;

use Data::Validator;

around BUILDARGS => sub {
    state $rule = Data::Validator->new(
        code => { xor => [qw(name)], optional => 1 },
        name => { xor => [qw(code)], optional => 1 },
    )->with('Method');
    my ($next, $class, $init_args) = (shift, $rule->validate(@_));

    return $class->$next($init_args);
};

1;
__END__
