module NationalGrid
  module Inspect
    def inspect
      "#<#{self.class.name}:0x%x #{inspect_attributes}>" % object_id
    end
  end
end
