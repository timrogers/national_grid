#pragma once
#include <national_grid.h>

extern VALUE cNationalGridLatitudeLongitude;
void Init_national_grid_latitude_longitude();
VALUE new_national_grid_latitude_longitude(LatLonDecimal data);
