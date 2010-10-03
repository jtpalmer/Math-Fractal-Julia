use strict;
use warnings;

use Test::More tests => 5;
BEGIN { use_ok('Math::Fractal::Julia') }

can_ok( 'Math::Fractal::Julia',
    qw( set_max_iter set_limit set_bounds set_constant ) );

eval {
    my $julia = Math::Fractal::Julia->new();
    pass('Math::Fractal::Julia->new()');
};
if ($@) {
    fail('Math::Fractal::Julia->new()');
}

my $julia = Math::Fractal::Julia->new();

isa_ok($julia, 'Math::Fractal::Julia');

is($julia->set_max_iter(4), 4);

