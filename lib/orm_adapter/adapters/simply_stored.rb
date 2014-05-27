require 'simply_stored'
require 'orm_adapter'
module SimplyStored
  module Couch
    module ClassMethods
      include ::OrmAdapter::ToAdapter
    end

    class OrmAdapter < ::OrmAdapter::Base

      # get a list of column names for a given class
      def column_names
        klass.property_names.map(&:to_s)
      end

      # @see OrmAdapter::Base#get!
      def get!(id)
        klass.find(wrap_key(id))
      end

      # @see OrmAdapter::Base#get
      def get(id)
        klass.find(wrap_key(id)) rescue nil
      end

      # @see OrmAdapter::Base#find_first
      def find_first(conditions = {})
        conditions, order = extract_conditions!(conditions)
        return klass.first if conditions.blank?
        method = "find_by_#{conditions.keys.map{|k| k.to_s == 'id' ? '_id' : k}.join('_and_')}"
        values = conditions.values
        klass.send(method, *values)
      end

      # @see OrmAdapter::Base#find_all
      def find_all(conditions = {})
        conditions, order, limit, offset = extract_conditions!(conditions)
        options = {}
        options[:limit] = limit if limit
        options[:skip] = offset if offset
        return klass.all(options) if conditions.blank?
        method = "find_all_by_#{conditions.keys.map{|k| k.to_s == 'id' ? '_id' : k}.join('_and_')}"
        values = conditions.values
        values << options
        klass.send(method, *values)
      end


      # @see OrmAdapter::Base#create!
      def create!(attributes = {})
        klass.create!(attributes)
      end

      # @see OrmAdapter::Base#destroy
      def destroy(object)
        object.destroy and object.id.blank? if valid_object?(object)
      end

    end
  end
end
