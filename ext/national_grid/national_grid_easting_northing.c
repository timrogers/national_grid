#include <national_grid_easting_northing.h>

VALUE cNationalGridEastingNorthing;

static EastingNorthing* easting_northing(VALUE self) {
  EastingNorthing* data;
  Data_Get_Struct(self, EastingNorthing, data);
  return data;
}

static VALUE allocate(VALUE class) {
  EastingNorthing* data = ALLOC(EastingNorthing);
  return Data_Wrap_Struct(class, NULL, xfree, data);
}

static VALUE initialize(int argc, VALUE* argv, VALUE self) {
  VALUE easting, northing, elevation;
  rb_scan_args(argc, argv, "03", &easting, &northing, &elevation);

  EastingNorthing* data = easting_northing(self);
  data->e = default_to_zero(easting);
  data->n = default_to_zero(northing);
  data->elevation = default_to_zero(elevation);

  return self;
}

static VALUE easting(VALUE self) {
  return DBL2NUM(easting_northing(self)->e);
}

static VALUE northing(VALUE self) {
  return DBL2NUM(easting_northing(self)->n);
}

static VALUE elevation(VALUE self) {
  return DBL2NUM(easting_northing(self)->elevation);
}

static VALUE to_latitude_longitude(VALUE self) {
  LatLonDecimal data = ETRS89LatLonFromETRS89EastingNorthing(ETRS89EastingNorthingFromOSGB36EastingNorthing(*easting_northing(self)));
  if (data.geoid == 0) return Qnil;
  return new_national_grid_latitude_longitude(data);
}

void Init_national_grid_easting_northing() {
  cNationalGridEastingNorthing = rb_define_class_under(mNationalGrid, "EastingNorthing", rb_cObject);
  rb_define_alloc_func(cNationalGridEastingNorthing, allocate);
  rb_define_method(cNationalGridEastingNorthing, "initialize", initialize, -1);
  rb_define_method(cNationalGridEastingNorthing, "easting", easting, 0);
  rb_define_method(cNationalGridEastingNorthing, "northing", northing, 0);
  rb_define_method(cNationalGridEastingNorthing, "elevation", elevation, 0);
  rb_define_method(cNationalGridEastingNorthing, "to_latitude_longitude", to_latitude_longitude, 0);
}

VALUE new_national_grid_easting_northing(EastingNorthing data) {
  VALUE instance = allocate(cNationalGridEastingNorthing);
  *easting_northing(instance) = data;
  return instance;
}
