#!perl
use strict;
use warnings;
use Test::More;
use Math::Fractal::Julia;

can_ok( 'Math::Fractal::Julia', qw( new ) );

can_ok( 'Math::Fractal::JuliaPtr',
    qw( set_max_iter set_limit set_bounds set_constant ) );

my $julia = Math::Fractal::Julia->new();

ok( $julia, 'new' );

isa_ok( $julia, 'Math::Fractal::JuliaPtr' );

eval {
    $julia->set_max_iter(4);
    pass('set_max_iter');
    1;
} or do {
    fail('set_max_iter');
};

eval {
    $julia->set_bounds( -1, -1, 1, 1, 640, 480 );
    pass('set_bounds');
    1;
} or do {
    fail('set_bounds');
};

eval {
    $julia->set_constant( 0.5, 0.5 );
    pass('set_constant');
    1;
} or do {
    fail('set_constant');
};

eval {
    $julia->point( 1, 1 );
    pass('point');
    1;
} or do {
    fail('point');
};

done_testing();

