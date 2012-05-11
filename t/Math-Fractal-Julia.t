use strict;
use warnings;

use Test::More tests => 8;
use Math::Fractal::Julia;

can_ok( 'Math::Fractal::Julia',
    qw( new set_max_iter set_limit set_bounds set_constant ) );

eval {
    my $julia = Math::Fractal::Julia->new();
    pass('Math::Fractal::Julia->new()');
};
if ($@) {
    fail('Math::Fractal::Julia->new()');
}

my $julia = Math::Fractal::Julia->new();

isa_ok( $julia, 'Math::Fractal::JuliaPtr' );

eval {
    $julia->set_max_iter(4);
    pass('set_max_iter()');
};
if ($@) {
    fail('set_max_iter()');
}

eval {
    $julia->set_bounds( -1, -1, 1, 1, 640, 480 );
    pass('set_bounds()');
};
if ($@) {
    fail('set_bounds()');
}

eval {
    $julia->set_constant( 0.5, 0.5 );
    pass('set_constant()');
};
if ($@) {
    fail('set_constant()');
}

eval {
    $julia->point( 1, 1 );
    pass('point()');
};
if ($@) {
    fail('point()');
}
