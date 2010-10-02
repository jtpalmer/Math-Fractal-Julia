use strict;
use warnings;

use Math::Fractal::Julia;
use Imager;

my $width  = 640;
my $height = 480;
my $view   = [ -1.6, -1.2, 1.6, 1.2 ];    # [ min_x, $min_y, $max_x, $max_y]

Math::Fractal::Julia->set_max_iter(255);
Math::Fractal::Julia->set_bounds( @$view, $width, $height );

# See http://en.wikipedia.org/wiki/File:Julia_set_%28ice%29.png
Math::Fractal::Julia->set_constant( -0.726895347709114071439,
    0.188887129043845954792 );

my @palette = map { [ $_, $_, $_ ] } 0 .. 255;
$palette[0] = [ 255, 255, 255 ];

my $img = Imager->new( xsize => $width, ysize => $height );

foreach my $y ( 0 .. $height - 1 ) {
    foreach my $x ( 0 .. $width - 1 ) {
        my $iter = Math::Fractal::Julia->point( $x, $height - $y - 1 );
        $img->setpixel( x => $x, y => $y, color => $palette[$iter] );
    }
}

$img->write( file => 'julia.png' );
