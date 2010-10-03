package Math::Fractal::Julia;

# ABSTRACT: Calculate points in the Julia set

use 5.008000;
use strict;
use warnings;

require XSLoader;
XSLoader::load('Math::Fractal::Julia', $Math::Fractal::Julia::VERSION);

1;
__END__

=head1 SYNOPSIS

  use Math::Fractal::Julia;

  # Procedural usage (like Math::Fractal::Mandelbrot):
  Math::Fractal::Julia->set_max_iter($iters);
  Math::Fractal::Julia->set_limit($limit);
  Math::Fractal::Julia->set_bounds( $x1, $y1, $x2, $y2, $w, $h );
  Math::Fractal::Julia->set_constant( $cx, $cy );
  my $iter = Math::Fractal::Julia->point( $x, $y );

  # Object Oriented usage:
  my $julia = Math::Fractal::Julia->new(%options);
  $julia->set_max_iter($iters);
  $julia->set_limit($limit);
  $julia->set_bounds( $x1, $y1, $x2, $y2, $w, $h );
  $julia->set_constant( $cx, $cy );
  my $iter = $julia->point( $x, $y );

=head1 DESCRIPTION

Calculates points in the set named after the French mathematician Gaston
Julia.

=head1 METHODS

=head2 new()

=head2 new(%options)

  my $julia = Math::Fractal::Julia->new();
  my $julia = Math::Fractal::Julia->new(%options);

Creates a new Math::Fractal::Object.  If no options are provided, the default
values will be used.

Options:

=over 4

=item * max_iter => $iters

=item * limit => $limit

=item * bounds => [ $x1, $x2, $y1, $y2, $width, $height ]

=item * constant => [ $cx, $cy ]

=back

=head2 set_max_iter($max)

  Math::Fractal::Julia->set_max_iter($max);
  $julia->set_max_iter($max);

=head2 set_limit($limit)

  Math::Fractal::Julia->set_limit($limit);
  $julia->set_limit($limit);

=head2 set_bounds( $x1, $x2, $y1, $y2, $width, $height )

  Math::Fractal::Julia->set_bounds( $x1, $x2, $y1, $y2, $width, $height );
  $julia->set_bounds( $x1, $x2, $y1, $y2, $width, $height );

=head2 set_constant( $cx, $cy )

  Math::Fractal::Julia->set_constant( $cx, $cy );
  $julia->set_constant( $cx, $cy );

=head2 point( $x, $y )

  $iter = Math::Fractal::Julia->point( $x, $y );
  $iter = $julia->point( $x, $y );

=head1 SEE ALSO

L<Math::Fractal::Mandelbrot>

=cut
