module NationalGrid
  class LatitudeLongitude
    include Inspect
    include Round

    def to_a
      [latitude, longitude, elevation]
    end

    private

    def inspect_attributes
      "latitude=%.6f longitude=%.6f elevation=%.3f" % to_a
    end
  end
end
