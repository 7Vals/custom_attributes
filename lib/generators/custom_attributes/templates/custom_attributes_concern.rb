module <%= name %>CustomAttributes
  extend ActiveSupport::Concern

  included do
    has_many :custom_attribute_values, :class_name=>'<%= name %>CustomAttributeValue', autosave: true

    def custom_attributes=(map_of_custom_attributes)
      map_of_custom_attributes.each do |key, value|
        custom_attribute_value = custom_attribute_values.find { |cav| cav.name==key }
        if not custom_attribute_value
    <% if options.tenant %>
          custom_attribute_defns = <%= name %>CustomAttributeDefinition.all.current_tenant(<%= options.tenant %>_id)
    <% else %>
          custom_attribute_defns = <%= name %>CustomAttributeDefinition.all
    <% end %>
          custom_attribute_defn = custom_attribute_defns.find { |cad| cad.attr_name == key }
          custom_attribute_value = <%= name %>CustomAttributeValue.initialize(custom_attribute_defn)
          self.custom_attribute_values.push(custom_attribute_value)
        end
        custom_attribute_value.value = value
      end
    end

    def custom_attributes
    <% if options.tenant %>
      custom_attribute_defns = <%= name %>CustomAttributeDefinition.all.current_tenant(<%= options.tenant %>_id)
    <% else %>
      custom_attribute_defns = <%= name %>CustomAttributeDefinition.all
    <% end %>
      custom_attribute_defns.collect { |defn|
        custom_attribute_values.find { |cv| cv.custom_attribute_defn==defn } || <%= name %>CustomAttributeValue.initialize(defn)
      }
    end
  end

end