# frozen_string_literal: true

require "wholable/equatable"

# Main namespace.
module Wholable
  def self.[](...) = Equatable.new(...)
end
