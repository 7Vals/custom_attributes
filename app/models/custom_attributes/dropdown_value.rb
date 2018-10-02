module CustomAttributes
  module DropdownValue
    def value=(custom_attribute_option_label)
      custom_attribute_option = custom_attribute_options.find_by label: custom_attribute_option_label
      if (custom_attribute_option_value = custom_attribute_option_values.first).present?
        custom_attribute_option_value.custom_attribute_option = custom_attribute_option
        custom_attribute_option_value.save
      else
        custom_attribute_option_values.build custom_attribute_option: custom_attribute_option
      end
    end

    def value
      custom_attribute_option_values.first.try(:custom_attribute_option).try(:label)
    end
  end
end