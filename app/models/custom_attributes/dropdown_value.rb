module CustomAttributes
  module DropdownValue
    def value=(custom_attribute_option_id)
      custom_attribute_option = custom_attribute_options.find_by id: custom_attribute_option_id
      if (custom_attribute_option_value = custom_attribute_option_values.first).present?
        if custom_attribute_option.present?
          custom_attribute_option_value.custom_attribute_option = custom_attribute_option
          custom_attribute_option_value.save
        else
          custom_attribute_option_value.destroy
        end
      else
        custom_attribute_option_values.build custom_attribute_option: custom_attribute_option if custom_attribute_option.present?
      end
    end

    def value
      custom_attribute_option_values.first.try(:custom_attribute_option).try(:label)
    end

    def selected_option
      custom_attribute_option_values.first.try(:custom_attribute_option).try(:id)
    end
  end
end