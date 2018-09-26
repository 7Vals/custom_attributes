module CustomAttributes
  module DropdownValue
    def value=(custom_attribute_option_id)
      if (custom_attribute_option_value = custom_attribute_option_values.first).present?
        custom_attribute_option_value.update custom_attribute_option_id: custom_attribute_option_id
      else
        custom_attribute_option_values.create custom_attribute_option_id: custom_attribute_option_id
      end
    end

    def value
      custom_attribute_option_values.first.try(:custom_attribute_option).try(:label)
    end
  end
end