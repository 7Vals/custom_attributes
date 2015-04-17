require "custom_attributes/engine"
require "custom_attributes/setup"

module CustomAttributes
  extend ActiveSupport::Concern

	included do
    has_many :custom_attribute_values, :as => :owner, :class_name => 'CustomAttributes::CustomAttributeValue'

    def custom_attributes=(map_of_custom_attributes)
      map_of_custom_attributes.each do |key, value|
        custom_attribute_value = custom_attribute_values.find { |cav| cav.name==key }
        if not custom_attribute_value
          custom_attribute = self.class.allowed_custom_attributes.find { |ca| ca.attr_name == key }
          custom_attribute_value = CustomAttributeValue.new(custom_attribute: custom_attribute)
          self.custom_attribute_values.push(custom_attribute_value)
        end
        custom_attribute_value.value = value
      end
    end

    def custom_attributes
      custom_attribute_defns = self.class.allowed_custom_attributes
      custom_attribute_defns.collect { |defn|
        custom_attribute_values.find { |cv| cv.custom_attribute==defn } || CustomAttributes::CustomAttributeValue.new(custom_attribute: defn)
      }
    end

    def add_custom_attribute_value

    end
  end

  module ClassMethods
    def allowed_custom_attributes
      #TODO: rename owner_class to owner_type
      CustomAttribute.where(owner_class: self)
    end

    def add_allowed_custom_attribute
      
    end
  end
end

ActiveSupport.on_load(:active_record) do
  include CustomAttributes::Setup
end