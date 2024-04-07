module Wholable
  module Collection
    def self.[](...) = EquatableCollection.new(...)
  end
end
