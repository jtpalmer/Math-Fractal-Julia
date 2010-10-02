#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

typedef struct Julia {
    double limit;
    unsigned int max_iter;
    double x_const;
    double y_const;
    double x_min;
    double y_min;
    double x_max;
    double y_max;
    unsigned int width ;
    unsigned int height;
} Julia;

Julia myinstance = { 5, 600, 0, 0, -2.2, -1.1, 1.0, 1.1, 640, 480 };


MODULE = Math::Fractal::Julia		PACKAGE = Math::Fractal::Julia		
PROTOTYPES: ENABLE

unsigned int
set_max_iter(myclass, max_iter)
        unsigned int max_iter
    CODE:
        myinstance.max_iter = max_iter;
        RETVAL = myinstance.max_iter;
    OUTPUT:
        RETVAL

double
set_limit(myclass, limit)
        double limit
    CODE:
        myinstance.limit = limit;
        RETVAL = myinstance.limit;
    OUTPUT:
        RETVAL

void
set_bounds(myclass, x_min, y_min, x_max, y_max, width, height)
        double x_min
        double y_min
        double x_max
        double y_max
	unsigned int width
	unsigned int height
    CODE:
        myinstance.x_min = x_min;
        myinstance.y_min = y_min;
        myinstance.x_max = x_max;
        myinstance.y_max = y_max;
        myinstance.width = width;
        myinstance.height = height;

void
set_constant(myclass, x, y)
        double x
        double y
    CODE:
	myinstance.x_const = x;
	myinstance.y_const = y;

unsigned int
point(myclass, x, y)
        double x
        double y
    CODE:
        unsigned int n;
        n = 0;
        RETVAL = n;
    OUTPUT:
        RETVAL
