# frozen_string_literal: true

module Wholable
  # Provides object equality comparison methods.
  module Comparable
    def eql?(other) = instance_of?(other.class) && hash == other.hash

    def ==(other) = other.is_a?(self.class) && hash == other.hash
  end
end
