module CustomAttributes
  module CheckboxValue
    def value=(custom_attribute_option_ids)
      new_selected_options = custom_attribute_options.where(id: custom_attribute_option_ids)
      if (old_selected_options = custom_attribute_option_values).present?
        if new_selected_options.present?
          options_to_destroy = old_selected_options.where.not(id: new_selected_options.ids)
          options_to_destroy.destroy_all
          options_to_create =
            if old_selected_options.present?
              new_selected_options.where.not(id: old_selected_options.ids)
            else
              new_selected_options
            end
          options_to_create.each do |option|
            custom_attribute_option_values.create custom_attribute_option: option
          end
        else
          old_selected_options.destroy_all
        end
      elsif new_selected_options.present?
        if new_record?
          new_selected_options.each do |option|
            custom_attribute_option_values.build custom_attribute_option: option
          end
        else
          new_selected_options.each do |option|
            custom_attribute_option_values.create custom_attribute_option: option
          end
        end
      end
    end

    def value
      custom_attribute_option_values.first.try(:custom_attribute_option).try(:label)
    end

    def selected_option_id
      custom_attribute_option_values.first.try(:custom_attribute_option).try(:id)
    end
  end
end
