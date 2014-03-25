# NationalGrid

NationalGrid is a Ruby binding to [OSTN02C](https://github.com/jawj/OSTN02C), which converts between National Grid easting-northing coordinates (OSGB36) and GPS latitude-longitude coordinates (ETRS89) using the OSTN02 transformation.

## Installation

Add this line to your application's Gemfile:

    gem 'national_grid'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install national_grid

## Usage

```irb
require "national_grid"

NationalGrid::EastingNorthing.new(362269.979, 169978.688, 54.467).to_latitude_longitude
=> #<NationalGrid::LatitudeLongitude:0x3ff8f955f0b4 latitude=51.427547 longitude=-2.544076 elevation=104.018>

NationalGrid::LatitudeLongitude.new(53.779110, -3.040455, 64.940).to_easting_northing
=> #<NationalGrid::EastingNorthing:0x3ff8f995f04c easting=331534.545 northing=431920.763 elevation=12.636>
```
