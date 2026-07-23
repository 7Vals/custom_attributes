module CustomAttributes
  module DropdownValue

    def display_value
      value
    end

    def value=(args)
      # Rails nested params arrive as ActionController::Parameters (not a Hash).
      args = args.to_unsafe_h if args.respond_to?(:to_unsafe_h)

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
        linkable_resource_display_value
      else
        custom_attribute_option_values.first.try(:custom_attribute_option).try(:label)
      end
    end

    def linkable_resource_display_value
      # This class method (linkable_resource_display_value) is defined in gem but should be overridden in the codebase
      # If it's called under the scope of module CustomAttributes, scope resolution operator should be use.
      ::CustomAttributeDefinitionLinkedModule.linkable_resource_display_value(linkable_resource)
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