# frozen_string_literal: true

module Wholable
  # Provides object equality comparison methods.
  module Comparable
    def eql?(other) = instance_of?(other.class) && hash == other.hash

    def ==(other) = other.is_a?(self.class) && hash == other.hash

    def diff other
      if other.is_a? self.class
        to_h.merge(other.to_h) { |_, one, two| [one, two].uniq }
            .select { |_, diff| diff.size == 2 }
      else
        to_h.each.with_object({}) { |(key, value), diff| diff[key] = [value, nil] }
      end
    end
  end
end
