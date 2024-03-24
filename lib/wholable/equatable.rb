# frozen_string_literal: true

module Wholable
  # Provides core equality behavior.
  class Equatable < Module
    def initialize *keys
      super()
      @keys = keys.uniq
      define_instance_methods
      freeze
    end

    def included descendant
      super
      define_class_methods descendant
      descendant.include Comparable
      descendant.prepend Freezable
    end

    private

    attr_reader :keys

    def define_instance_methods
      define_hash
      define_inspect
      define_with
      define_to_a
      define_to_h
      define_diff
    end

    def define_class_methods descendant
      descendant.class_eval <<-READER, __FILE__, __LINE__ + 1
        attr_reader #{keys.map(&:inspect).join ", "}
      READER

      descendant.alias_method :deconstruct, :to_a
      descendant.alias_method :deconstruct_keys, :to_h
    end

    def define_with
      define_method(:with) { |**attributes| self.class.new(**to_h.merge!(attributes)) }
    end

    def define_hash local_keys = keys
      define_method :hash do
        local_keys.map { |key| public_send key }
                  .prepend(self.class)
                  .hash
      end
    end

    def define_inspect local_keys = keys
      define_method :inspect do
        klass = self.class
        name = klass.name || klass.inspect

        local_keys.map { |key| "@#{key}=#{public_send(key).inspect}" }
                  .join(", ")
                  .then { |pairs| "#<#{name} #{pairs}>" }
      end
    end

    def define_to_a local_keys = keys
      define_method :to_a do
        local_keys.reduce([]) { |array, key| array.append public_send(key) }
      end
    end

    def define_to_h local_keys = keys
      define_method :to_h do
        local_keys.each.with_object({}) { |key, dictionary| dictionary[key] = public_send key }
      end
    end

    def define_diff
      define_method :diff do |other|
        if other.is_a? self.class
          to_h.merge!(other.to_h) { |_, one, two| [one, two].uniq }
              .select { |_, diff| diff.size == 2 }
        else
          to_h.each.with_object({}) { |(key, value), diff| diff[key] = [value, nil] }
        end
      end
    end
  end
end
