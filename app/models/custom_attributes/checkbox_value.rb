module CustomAttributes
  module CheckboxValue
    def value=(custom_attribute_option_ids)
      new_selected_options = custom_attribute_options.where(id: custom_attribute_option_ids)
      if (old_selected_options = custom_attribute_option_values).present?
        if new_selected_options.present?
          options_to_destroy = old_selected_options.where.not(id: new_selected_options.ids)
          destroy_options(options_to_destroy)
          options_to_create =
            if old_selected_options.present?
              new_selected_options.where.not(id: old_selected_options.ids)
            else
              new_selected_options
            end
          create_options(options_to_create)
        else
          destroy_options(old_selected_options)
        end
      elsif new_selected_options.present?
        if new_record?
          new_selected_options.each do |option|
            custom_attribute_option_values.build custom_attribute_option: option
          end
        else
          create_options(new_selected_options)
        end
      end
    end

    def value
      custom_attribute_option_values.first.try!(:custom_attribute_option).try!(:label)
    end

    def selected_option_id
      custom_attribute_option_values.first.try!(:custom_attribute_option).try!(:id)
    end

    def destroy_options(options_to_destroy)
      options_to_destroy_size = options_to_destroy.size
      destroyed_options = options_to_destroy.destroy_all
      raise EzOfficeExceptions::ValidationError if destroyed_options.size != options_to_destroy_size
    end

    def create_options(options_to_create)
      options_to_create.each do |option|
        custom_attribute_option_values.create! custom_attribute_option: option
      end
    end
  end
end
