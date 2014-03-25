#include <national_grid_latitude_longitude.h>

VALUE cNationalGridLatitudeLongitude;

static LatLonDecimal* latitude_longitude(VALUE self) {
  LatLonDecimal* data;
  Data_Get_Struct(self, LatLonDecimal, data);
  return data;
}

static VALUE allocate(VALUE class) {
  LatLonDecimal* data = ALLOC(LatLonDecimal);
  return Data_Wrap_Struct(class, NULL, xfree, data);
}

static VALUE initialize(int argc, VALUE* argv, VALUE self) {
  VALUE latitude, longitude, elevation;
  rb_scan_args(argc, argv, "03", &latitude, &longitude, &elevation);

  LatLonDecimal* data = latitude_longitude(self);
  data->lat = default_to_zero(latitude);
  data->lon = default_to_zero(longitude);
  data->elevation = default_to_zero(elevation);

  return self;
}

static VALUE latitude(VALUE self) {
  return DBL2NUM(latitude_longitude(self)->lat);
}

static VALUE longitude(VALUE self) {
  return DBL2NUM(latitude_longitude(self)->lon);
}

static VALUE elevation(VALUE self) {
  return DBL2NUM(latitude_longitude(self)->elevation);
}

static VALUE to_easting_northing(VALUE self) {
  EastingNorthing data = OSGB36EastingNorthingFromETRS89EastingNorthing(ETRS89EastingNorthingFromETRS89LatLon(*latitude_longitude(self)));
  if (data.geoid == 0) return Qnil;
  return new_national_grid_easting_northing(data);
}

void Init_national_grid_latitude_longitude() {
  cNationalGridLatitudeLongitude = rb_define_class_under(mNationalGrid, "LatitudeLongitude", rb_cObject);
  rb_define_alloc_func(cNationalGridLatitudeLongitude, allocate);
  rb_define_method(cNationalGridLatitudeLongitude, "initialize", initialize, -1);
  rb_define_method(cNationalGridLatitudeLongitude, "latitude", latitude, 0);
  rb_define_method(cNationalGridLatitudeLongitude, "longitude", longitude, 0);
  rb_define_method(cNationalGridLatitudeLongitude, "elevation", elevation, 0);
  rb_define_method(cNationalGridLatitudeLongitude, "to_easting_northing", to_easting_northing, 0);
}

VALUE new_national_grid_latitude_longitude(LatLonDecimal data) {
  VALUE instance = allocate(cNationalGridLatitudeLongitude);
  *latitude_longitude(instance) = data;
  return instance;
}
