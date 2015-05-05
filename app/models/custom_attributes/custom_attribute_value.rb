module CustomAttributes
  class CustomAttributeValue < ActiveRecord::Base
    belongs_to :custom_attribute, class_name: "CustomAttributes::CustomAttribute", foreign_key: "custom_attributes_custom_attribute_id"

    def name
      custom_attribute.attr_name
    end

    def value
      #TODO: return based on type
      string_value || integer_value
    end

    def value=(newVal)
      #TODO: checks here based on type
      self.string_value = newVal
    end
  end
end
