# frozen_string_literal: true

require "wholable/equatable"
require "wholable/freezable"

# Main namespace.
module Wholable
  def self.[](...) = Equatable.new(...)
end
