#include <national_grid.h>

VALUE mNationalGrid;

void Init_national_grid() {
  mNationalGrid = rb_define_module("NationalGrid");

  Init_national_grid_easting_northing();
  Init_national_grid_latitude_longitude();
}
