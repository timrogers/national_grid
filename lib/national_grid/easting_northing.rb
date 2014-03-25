module NationalGrid
  class EastingNorthing
    include Inspect

    def to_a
      [easting, northing, elevation]
    end

    private

    def inspect_attributes
      "easting=%.3f northing=%.3f elevation=%.3f" % to_a
    end
  end
end
