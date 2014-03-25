require "minitest/autorun"
require "national_grid"

module NationalGrid
  class LatitudeLongitudeTest < Minitest::Test
    def test_initialize_with_defaults
      point = LatitudeLongitude.new

      assert_equal 0, point.latitude
      assert_equal 0, point.longitude
      assert_equal 0, point.elevation
    end

    def test_initialize_with_latitude_and_longitude
      point = LatitudeLongitude.new(12.3, 45.6)

      assert_equal 12.3, point.latitude
      assert_equal 45.6, point.longitude
      assert_equal 0, point.elevation
    end

    def test_initialize_with_latitude_longitude_and_elevation
      point = LatitudeLongitude.new(12.3, 45.6, 789.0)

      assert_equal 12.3, point.latitude
      assert_equal 45.6, point.longitude
      assert_equal 789.0, point.elevation
    end

    def test_inspect
      assert_match /^#<NationalGrid::LatitudeLongitude:0x\h+ latitude=12.345678 longitude=90.123456 elevation=789.012>$/, LatitudeLongitude.new(12.3456779, 90.1234559, 789.0119).inspect
    end

    def test_to_a
      assert_equal [12.3, 45.6, 789.0], LatitudeLongitude.new(12.3, 45.6, 789.0).to_a
    end

    def test_to_easting_northing
      assert_close EastingNorthing.new(331534.545, 431920.763, 12.636), LatitudeLongitude.new(53.779110, -3.040455, 64.940).to_easting_northing
    end

    def test_to_easting_northing_when_outside_the_grid
      assert_nil LatitudeLongitude.new(-45.878761, 170.502798).to_easting_northing
    end

    private

    def assert_close(expected, actual)
      assert_in_delta expected.easting, actual.easting, 0.5e-3
      assert_in_delta expected.northing, actual.northing, 0.5e-3
      assert_in_delta expected.elevation, actual.elevation, 0.5e-3
    end
  end
end
