#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

typedef struct Math_Fractal_Julia {
    double limit;
    unsigned int max_iter;
    double x_const;
    double y_const;
    double x_min;
    double y_min;
    double x_max;
    double y_max;
    unsigned int width;
    unsigned int height;
} Math_Fractal_Julia;

unsigned int _point(Math_Fractal_Julia *j, unsigned int x, unsigned int y) {
    unsigned int n;
    double x1, y1, x2, y2, xtemp;
    n = 0;
    x1 = x * (j->x_max - j->x_min) / j->width  + j->x_min;
    y1 = y * (j->y_max - j->y_min) / j->height + j->y_min;
    while (++n < j->max_iter) {
        x2 = x1 * x1;
        y2 = y1 * y1;
        if (x2 + y2 > j->limit) {
            break;
        }
        xtemp = x2 - y2 + j->x_const;
        y1 = 2 * x1 * y1 + j->y_const;
        x1 = xtemp;
    }
    if (n == j->max_iter) {
        n = 0;
    }
    return n;
}

#define MY_CXT_KEY "Math::Fractal::Julia::_guts" XS_VERSION

typedef struct {
    Math_Fractal_Julia julia;
} my_cxt_t;

START_MY_CXT

MODULE = Math::Fractal::Julia	PACKAGE = Math::Fractal::Julia	PREFIX = julia_
PROTOTYPES: ENABLE

BOOT:
{
    MY_CXT_INIT;
    MY_CXT.julia.limit    = 5;
    MY_CXT.julia.max_iter = 600;
    MY_CXT.julia.x_const  = 0.0;
    MY_CXT.julia.y_const  = 0.0;
    MY_CXT.julia.x_min    = -2.2;
    MY_CXT.julia.y_min    = -1.1;
    MY_CXT.julia.x_max    = 1.0;
    MY_CXT.julia.y_max    = 1.1;
    MY_CXT.julia.width    = 640;
    MY_CXT.julia.height   = 480;
} 

unsigned int
julia_set_max_iter(myclass, max_iter)
        unsigned int max_iter
    CODE:
        dMY_CXT;
        MY_CXT.julia.max_iter = max_iter;
        RETVAL = MY_CXT.julia.max_iter;
    OUTPUT:
        RETVAL

double
julia_set_limit(myclass, limit)
        double limit
    CODE:
        dMY_CXT;
        MY_CXT.julia.limit = limit;
        RETVAL = MY_CXT.julia.limit;
    OUTPUT:
        RETVAL

void
julia_set_bounds(myclass, x_min, y_min, x_max, y_max, width, height)
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
julia_set_constant(myclass, x, y)
        double x
        double y
    CODE:
        dMY_CXT;
	MY_CXT.julia.x_const = x;
	MY_CXT.julia.y_const = y;

unsigned int
julia_point(myclass, x, y)
        unsigned int x
        unsigned int y
    INIT:
        unsigned int n;
        double x1, y1, x2, y2, xtemp;
        Math_Fractal_Julia j;
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

Math_Fractal_Julia *
julia__new(CLASS)
        char* CLASS
    CODE:
        dMY_CXT;
        RETVAL = (Math_Fractal_Julia *) malloc(sizeof(Math_Fractal_Julia));
        RETVAL->limit    = MY_CXT.julia.limit;
        RETVAL->max_iter = MY_CXT.julia.max_iter;
        RETVAL->x_const  = MY_CXT.julia.x_const;
        RETVAL->y_const  = MY_CXT.julia.y_const;
        RETVAL->x_min    = MY_CXT.julia.x_min;
        RETVAL->y_min    = MY_CXT.julia.y_min;
        RETVAL->x_max    = MY_CXT.julia.x_max;
        RETVAL->y_max    = MY_CXT.julia.y_max;
        RETVAL->width    = MY_CXT.julia.width;
        RETVAL->height   = MY_CXT.julia.height;
    OUTPUT:
        RETVAL

MODULE = Math::Fractal::Julia	PACKAGE = Math::Fractal::JuliaPtr	PREFIX = juliaptr_

unsigned int
juliaptr_set_max_iter(self, max_iter)
        Math_Fractal_Julia *self
        unsigned int max_iter
    CODE:
        self->max_iter = max_iter;
        RETVAL = self->max_iter;
    OUTPUT:
        RETVAL

double
juliaptr_set_limit(self, limit)
        Math_Fractal_Julia *self
        double limit
    CODE:
        self->limit = limit;
        RETVAL = self->limit;
    OUTPUT:
        RETVAL

void
juliaptr_set_bounds(self, x_min, y_min, x_max, y_max, width, height)
        Math_Fractal_Julia *self
        double x_min
        double y_min
        double x_max
        double y_max
        unsigned int width
        unsigned int height
    CODE:
        self->x_min = x_min;
        self->y_min = y_min;
        self->x_max = x_max;
        self->y_max = y_max;
        self->width = width;
        self->height = height;

void
juliaptr_set_constant(self, x_const, y_const)
        Math_Fractal_Julia *self
        double x_const
        double y_const
    CODE:
        self->x_const = x_const;
        self->y_const = y_const;

double
juliaptr_point(self, x, y)
        Math_Fractal_Julia *self
        unsigned int x
        unsigned int y
    CODE:
        RETVAL = _point(self, x, y);
    OUTPUT:
        RETVAL

void
juliaptr_DESTROY(self)
        Math_Fractal_Julia *self
    CODE:
        free(self);
