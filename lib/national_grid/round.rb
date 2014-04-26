module NationalGrid
  module Round
    def round(decimal_places = 0)
      self.class.new(*to_a.map {|ordinate| ordinate.round(decimal_places)})
    end
  end
end
