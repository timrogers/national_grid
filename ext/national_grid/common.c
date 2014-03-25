#include <common.h>

double default_to_zero(VALUE value) {
  if (NIL_P(value)) return 0;
  return NUM2DBL(value);
}
