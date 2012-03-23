module Devise
  module Orm
    module SimplyStored
      def self.included(klass)
        klass.send(:extend, ::Devise::Models)
        klass.send(:extend, Hook)
        klass.send(:extend, Schema)
      end
      module Hook
        def devise_modules_hook!
          yield
          return unless Devise.apply_schema
          devise_modules.each { |m| send(m) if respond_to?(m, true) }
        end
        def to_adapter
          self
        end
        def find_first(conditions)
          if conditions.any?
            send(:"find_by_#{conditions.keys.join('_and_')}", *conditions.values)
          else
            first
          end
        end
        def get(ary)
          find Array.wrap(ary).first
        end
      end

      module Schema
        include Devise::Schema

        # Tell how to apply schema methods
        def apply_devise_schema(name, type, options={})
          type = Time if type == DateTime
          type = Fixnum if type == Integer
          property name, { :type => type }.merge!(options)
        end
      end
    end
  end
end
module SimplyStored::Couch
  def [](val)
    attributes[val]
  end
end
