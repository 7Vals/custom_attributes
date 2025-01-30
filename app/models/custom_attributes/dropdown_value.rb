module CustomAttributes
  module DropdownValue

    def display_value
      value
    end

    def value=(args)
      _set_values_for_linkable_resource(args) and return if args.is_a?(Hash)

      custom_attribute_option_id = args
      custom_attribute_option = custom_attribute_options.find_by id: custom_attribute_option_id
      if (custom_attribute_option_value = custom_attribute_option_values.first).present?
        if custom_attribute_option.present?
          custom_attribute_option_value.custom_attribute_option = custom_attribute_option
          custom_attribute_option_value.save
        else
          custom_attribute_option_value.destroy
        end
      else
        if custom_attribute_option.present?
          if new_record?
            custom_attribute_option_values.build custom_attribute_option: custom_attribute_option
          else
            custom_attribute_option_values.create custom_attribute_option: custom_attribute_option
          end
        end
      end
    end

    def value
      if respond_to?(:linkable_resource_id) && linkable_resource_id.present?
        linkable_resource_display_value || DEFAULT_FIELD_VALUE
      else
        custom_attribute_option_values.first.try(:custom_attribute_option).try(:label)
      end
    end

    def field_value(c_attr = custom_attribute_defn)
      if c_attr.linked_to_module_via_items_filtered_by_criteria?
        f_value = linkable_resource_display_value
        f_value == DEFAULT_FIELD_VALUE ? '' : f_value
      else
        value
      end
    end

    def selected_option_id
      custom_attribute_option_values.first.try(:custom_attribute_option).try(:id)
    end

    private

    # args = { linkable_resource_id:, linkable_resource_type:}
    def _set_values_for_linkable_resource(args)
      self.linkable_resource_id = args[:linkable_resource_id]
      self.linkable_resource_type = args[:linkable_resource_type]
    end
  end
end