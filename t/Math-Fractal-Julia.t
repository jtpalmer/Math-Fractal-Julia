use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('Math::Fractal::Julia') }

can_ok( 'Math::Fractal::Julia',
    qw( set_max_iter set_limit set_bounds set_constant ) );
