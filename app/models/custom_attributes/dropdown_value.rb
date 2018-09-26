module CustomAttributes
  module DropdownValue
    def value=(custom_attribute_option_id)
      if (custom_attribute_data = custom_attribute_value_datas.first).present?
        custom_attribute_data.update custom_attribute_option_id: custom_attribute_option_id
      else
        custom_attribute_value_datas.create custom_attribute_option_id: custom_attribute_option_id
      end
    end

    def value
      custom_attribute_value_datas.first.try(:custom_attribute_option).try(:label)
    end
  end
end