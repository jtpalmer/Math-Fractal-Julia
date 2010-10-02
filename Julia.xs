#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

double _limit = 5;
double _epsilon = 0.001;
unsigned int _max_iter = 600;
double _x_const = 0;
double _y_const = 0;
double _x_min = -2.2;
double _y_min = -1.1;
double _x_max =  1.0;
double _y_max =  1.1;
unsigned int _width  = 640;
unsigned int _height = 480;



MODULE = Math::Fractal::Julia		PACKAGE = Math::Fractal::Julia		
PROTOTYPES: ENABLE

unsigned int
set_max_iter(class, max_iter)
        unsigned int max_iter
    CODE:
        _max_iter = max_iter;
        RETVAL = _max_iter;
    OUTPUT:
        RETVAL

double
set_limit(class, limit)
        double limit
    CODE:
        _limit = limit;
        RETVAL = _limit;
    OUTPUT:
        RETVAL

double
set_epsilon(class, epsilon)
        double epsilon
    CODE:
        _epsilon = epsilon;
        RETVAL = _epsilon;
    OUTPUT:
        RETVAL

void
set_bounds(class, x_min, y_min, x_max, y_max, width, height)
        double x_min
        double y_min
        double x_max
        double y_max
	unsigned int width
	unsigned int height
    CODE:
        _x_min = x_min;
        _y_min = y_min;
        _x_max = x_max;
        _y_max = y_max;
        _width = width;
        _height = height;

void
set_constant(class, x, y)
        double x
        double y
    CODE:
	_x_const = x;
	_y_const = y;

unsigned int
point(class, x, y)
        double x
        double y
    CODE:
        unsigned int n;
        n = 0;
        RETVAL = n;
    OUTPUT:
        RETVAL
