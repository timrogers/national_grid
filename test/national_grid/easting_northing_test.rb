require "minitest/autorun"
require "national_grid"

module NationalGrid
  class EastingNorthingTest < Minitest::Test
    def test_initialize_with_defaults
      point = EastingNorthing.new

      assert_equal 0, point.easting
      assert_equal 0, point.northing
      assert_equal 0, point.elevation
    end

    def test_initialize_with_easting_and_northing
      point = EastingNorthing.new(12345.6, 78901.2)

      assert_equal 12345.6, point.easting
      assert_equal 78901.2, point.northing
      assert_equal 0, point.elevation
    end

    def test_initialize_with_easting_northing_and_elevation
      point = EastingNorthing.new(12345.6, 78901.2, 345.6)

      assert_equal 12345.6, point.easting
      assert_equal 78901.2, point.northing
      assert_equal 345.6, point.elevation
    end

    def test_inspect
      assert_match /^#<NationalGrid::EastingNorthing:0x\h+ easting=12345.678 northing=90123.456 elevation=789.012>$/, EastingNorthing.new(12345.6779, 90123.4559, 789.0119).inspect
    end

    def test_to_a
      assert_equal [12345.6, 78901.2, 345.6], EastingNorthing.new(12345.6, 78901.2, 345.6).to_a
    end

    def test_to_latitude_longitude
      assert_close LatitudeLongitude.new(51.427547, -2.544076, 104.018), EastingNorthing.new(362269.979, 169978.688, 54.467).to_latitude_longitude
    end

    def test_to_latitude_longitude_when_outside_the_grid
      assert_nil EastingNorthing.new(999999.999, 999999.999, 99.999).to_latitude_longitude
    end

    private

    def assert_close(expected, actual)
      assert_in_delta expected.latitude, actual.latitude, 0.5e-6
      assert_in_delta expected.longitude, actual.longitude, 0.5e-6
      assert_in_delta expected.elevation, actual.elevation, 0.5e-3
    end
  end
end
