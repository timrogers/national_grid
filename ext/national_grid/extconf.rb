require "mkmf"
require_relative "../ostn02c"

dir_config "ostn02c", [OSTN02C.include_path], [OSTN02C.lib_path]

abort "libostn02 not found" unless have_library "ostn02", "test(false)", "OSTN02.h"

create_makefile "national_grid/national_grid"
