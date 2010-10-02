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

#define MY_CXT_KEY "Math::Fractal::Julia::_guts" XS_VERSION

typedef struct {
    Julia julia;
} my_cxt_t;

START_MY_CXT

MODULE = Math::Fractal::Julia		PACKAGE = Math::Fractal::Julia		
PROTOTYPES: ENABLE

BOOT:
{
    MY_CXT_INIT;
    MY_CXT.julia.limit    = 5;
    MY_CXT.julia.max_iter = 600;
    MY_CXT.julia.x_const  = 0;
    MY_CXT.julia.y_const  = 0;
    MY_CXT.julia.x_min    = -2.2;
    MY_CXT.julia.y_min    = -1.1;
    MY_CXT.julia.x_max    = 1.0;
    MY_CXT.julia.y_max    = 1.1;
    MY_CXT.julia.width    = 640;
    MY_CXT.julia.height   = 480;
} 

unsigned int
set_max_iter(myclass, max_iter)
        unsigned int max_iter
    CODE:
        dMY_CXT;
        MY_CXT.julia.max_iter = max_iter;
        RETVAL = MY_CXT.julia.max_iter;
    OUTPUT:
        RETVAL

double
set_limit(myclass, limit)
        double limit
    CODE:
        dMY_CXT;
        MY_CXT.julia.limit = limit;
        RETVAL = MY_CXT.julia.limit;
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
        dMY_CXT;
        MY_CXT.julia.x_min = x_min;
        MY_CXT.julia.y_min = y_min;
        MY_CXT.julia.x_max = x_max;
        MY_CXT.julia.y_max = y_max;
        MY_CXT.julia.width = width;
        MY_CXT.julia.height = height;

void
set_constant(myclass, x, y)
        double x
        double y
    CODE:
        dMY_CXT;
	MY_CXT.julia.x_const = x;
	MY_CXT.julia.y_const = y;

unsigned int
point(myclass, x, y)
        unsigned int x
        unsigned int y
    INIT:
        unsigned int n;
        double x1, y1, x2, y2, xtemp;
        Julia j;
    CODE:
        dMY_CXT;
        j = MY_CXT.julia;
        n = 0;
        x1 = x * (j.x_max - j.x_min) / j.width  + j.x_min;
        y1 = y * (j.y_max - j.y_min) / j.height + j.y_min;
        while (++n < j.max_iter) {
            x2 = x1 * x1;
            y2 = y1 * y1;
            if (x2 + y2 > j.limit) {
                break;
            }
            xtemp = x2 - y2 + j.x_const;
            y1 = 2 * x1 * y1 + j.y_const;
            x1 = xtemp;
        }
        if (n == j.max_iter) {
            n = 0;
        }
        RETVAL = n;
    OUTPUT:
        RETVAL
