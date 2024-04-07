module Wholable
  class EquatableCollection < Equatable
    def included(descendant)
      define_class_methods(descendant)
      super(descendant)
    end

    private

    def define_class_methods(descendant)
      define_definer(descendant)
      define_all(descendant)
      define_field_collections(descendant)
      define_finder(descendant)
    end

    def define_definer(descendant)
      descendant.class_eval <<~DEFINER, __FILE__, __LINE__ + 1
        def self.define(symbol, instance)
          constant = const_set(symbol.to_s.upcase, instance)
          self.all << constant
        end
      DEFINER
    end

    def define_all(descendant)
      descendant.class_eval <<~ALL, __FILE__, __LINE__ + 1
        def self.all
          @_all ||= []
        end
      ALL
    end

    def define_field_collections(descendant)
      descendant.members.each do |field|
        define_field_collection(descendant, field)
      end
    end

    def define_field_collection(descendant, field)
      descendant.class_eval <<~FIELD_COLLECTION, __FILE__, __LINE__ + 1
        def self.#{field}s
          all.map(&:#{field})
        end
      FIELD_COLLECTION
    end

    def define_finder(descendant)
      descendant.class_eval <<~FINDER, __FILE__, __LINE__ + 1
        def self.find_by(field:, value:)
          all.find { |instance| instance.send(field) == value }
        end
      FINDER
    end
  end
end
