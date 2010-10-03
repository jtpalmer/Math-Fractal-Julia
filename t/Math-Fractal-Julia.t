use strict;
use warnings;

use Test::More tests => 3;
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
