module CustomAttributes
  class CustomAttributeValue < ActiveRecord::Base
    belongs_to :custom_attribute, class_name: "CustomAttributes::CustomAttribute", foreign_key: "custom_attributes_custom_attribute_id"

    def name
      custom_attribute.attr_name
    end

    def value
      #TODO: return based on type
      val = nil
      if (custom_attribute.attr_type == 'integer')
        val = integer_value
      else
        val = string_value
      end
      val
    end

    def value=(newVal)
      #TODO: checks here based on type
      if (custom_attribute.attr_type == 'integer')
        self.integer_value = newVal
      else
        self.string_value = newVal
      end
    end
  end
end
