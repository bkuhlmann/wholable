# frozen_string_literal: true

require "wholable/builder"

# Main namespace.
module Wholable
  def self.[](*) = Builder.new(*)
end
