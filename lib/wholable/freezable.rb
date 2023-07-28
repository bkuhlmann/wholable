# frozen_string_literal: true

module Wholable
  # Ensures an object is frozen after being initialized.
  module Freezable
    def initialize(...)
      super
      freeze
    end
  end
end
